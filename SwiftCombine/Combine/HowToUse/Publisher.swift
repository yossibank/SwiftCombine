import Combine
import Foundation

/**
 * Combineの基本としてまずは以下の３つのPublisher(値の発行者)について確認していきます
 * 1. 「Subject」
 * 2. 「Future」
 * 3. 「Just」
 */

// MARK: - 「Subject」

/** Subject
 * 一般的なPublisherはイベントが流れてくるだけのものです。
 * ただ、「Subject」はsend(_:)メソッドを呼び出すことにより、意図的に値を注入することができるPublisherです。
 * 「Subject」には2つの種類があります。
 *  1. CurrentValueSubject
 *  2. PassthroughSubject
 */

final class SubjectModel {

    /* 複数のAnyCancellable(イベントの購読をキャンセル処理)を一括で管理 */
    private var cancellables: Set<AnyCancellable> = .init()

    /** CurrentValueSubject
     * 1つの値をラップしてその値が変更されるたびに新しい要素を公開するSubject
     * Combine側で値を保持したい時に利用します。
     */

    /* Subject(Publisher)の定義*/
    private let currentSubject = CurrentValueSubject<[Int], Never>([]) // Neverはエラーを発生させない

    func executeCurrentSubject() {

        /* 値を送る */
        currentSubject.value.append(1)
        currentSubject.value.append(2)
        currentSubject.value.append(3)

        /* 処理が終了したことを伝える */
        currentSubject.send(completion: .finished)

        /* completionを投げた後はSubjectに対してsendメソッドを投げても実行されません */
        currentSubject.value.append(4)

        /* sinkメソッドを使用してPublisherを購読する */
        currentSubject.sink {
            print($0)
        }
        .store(in: &cancellables)

        /** 実行結果:
         * []
         * [1]
         * [1, 2]
         * [1, 2, 3]
         */
    }

    /** PassthroughSubject
     * 異なる値を保持しないSubject
     * 値を保持する必要がなく毎回データを更新(上書き)する時に利用します。
     */

    /* Subject(Publisher)の定義*/
    private let passthroughSubject = PassthroughSubject<Int, Never>()

    func executePassthroughSubject() {

        /* 値を送る */
        passthroughSubject.send(1)

        /* 処理が終了したことを伝える */
        passthroughSubject.send(completion: .finished)

        /* completionを投げた後はSubjectに対してsendメソッドを投げても実行されません */
        passthroughSubject.send(2)

        /* sinkメソッドを使用してPublisherを購読する */
        passthroughSubject.sink { completion in
            switch completion {
                case .finished:
                    print("finished")

                case .failure: // Neverはエラーを発生させないため本来は不要
                    print("failure")
            }
        } receiveValue: { value in
            print(value)
        }
        .store(in: &cancellables)

        /** 実行結果:
         * 1
         * finished
         */
    }
}

// MARK: - 「Future」

/** Future
 * 1つの値を非同期で生成して出力するか、失敗するPublisherです。
 * 「Aの処理が完了したらBの処理を実行する」という、これまで通信処理などで利用していたコールバック処理に使用できます。
 *
 * 例) 「20までカウントアップしたら特定の処理を実行する」というメソッドを作成します
 */

final class FutureModel {

    @Published var count = 0

    private let endCount = 20

    private var cancellables: Set<AnyCancellable> = .init()

    /* コールバック処理にCombineを使わない場合 */
    func startCounting(completionHandler: @escaping () -> Void) {
        /* every: 何秒毎にイベントを発行するか on: RunLoopを実行するスレッド in: RunLoop Modeの設定 */
        Timer.publish(every: 0.1, on: .main, in: .common)
            /* subscribeした時点で自動で処理を開始し、値の出力を始める */
            .autoconnect()
            /* 「いつ」(DispatchQueue, RunLoop...)「どこで」(main, global...)処理をするかを決める */
            .receive(on: RunLoop.main) /* RunLoop ← 入力系のスレッドを処理する機構(スクロール中に発火しない？) */
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.count < self.endCount {
                    self.count += 1
                } else {
                    completionHandler()
                }
            }
            .store(in: &self.cancellables)
    }

    /* コールバック処理にCombineのFutureを使った場合 */
    func startCounting() -> Future<Void, Never> {
        Future() { promise in
            Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .receive(on: RunLoop.main)
                .sink { _ in
                    if self.count < self.endCount {
                        self.count += 1
                    } else {
                        /* カウントアップが完了した時点でpromiseを実行する */
                        /* promiseを実行するとFutureは値を発行(公開)する */
                        promise(.success(()))
                    }
                }
                .store(in: &self.cancellables)
        }
    }
}

// MARK: - 「Deferred」

/** Deferred
 * 「Future」はインスタンスを生成した時点で中のクロージャが実行されますがこれには以下の懸念点があります
 *   1. Subscribeしていないのに処理が実行されるため無駄にリソースを消費する可能性がある
 *   2. 副作用を起こして思わぬ動作を起こす可能性がある
 *
 * - それに対して「Deferred」のクロージャはSubscribeした時に初めて実行されます
 */

final class DeferredModel {

    /* インスタンスを生成するだけで「Future 実行」のprint文が実行されます */
    let futurePublisher = Future<String, Never> { promise in
        print("Future 実行")
        promise(.success("Hello"))
    }

    let deferredPublisher = Deferred { () -> Just<String> in
        print("Deferred 実行")
        return Just("Hello")
    }
}

// MARK: - 「Just」

/** Just
 * 1つの値を即時出力し、終了するPublisherです。
 * 失敗することができず、必ず値を送信(発行)する特徴があります。
 *
 * 使い所:
 * → Catchを使って値を置き換える時
 *  https://developer.apple.com/documentation/combine/fail/catch(_:)
 *
 * → tryMapの処理がエラーとなった時
 *  https://developer.apple.com/documentation/combine/fail/trycatch(_:)
 */

final class JustModel {
    
    private let sample = "Hello World"

    private var cancellables: Set<AnyCancellable> = .init()

    func executeNoJust() {
        sample.publisher
            /* compactMap(_:)はCombineのOperatorの1つです(Operator.swiftで説明します) */
            .compactMap { String($0) }
            .sink { print($0) }
            .store(in: &cancellables)

        /** 出力結果:
         * H
         * e
         * l
         * l
         * o
         *
         * W
         * o
         * r
         * l
         * d
         */
    }

    func executeJust() {
        Just(sample)
            .compactMap { String($0) }
            .sink { print($0) }
            .store(in: &cancellables)

        /** 出力結果:
         * Hello World
         */
    }
}

// MARK: - Instance Method

/**
 * 代表的なものとしてsinkとassignがあります
 * - sink(receiveValue:)
 * - sink(receiveCompletion:receiveValue:)
 * - assign(to:on:)
 */

/** sink(receiveValue:)
 * - 必ず失敗しない、PublisherのFailureタイプがNeverの場合にのみ使用できます
 */

func sink(_ receiveValue: String) {
    var cancellable: AnyCancellable?
    let integers = [1, 2, 3]

    cancellable = integers.publisher.sink { print($0) }
    cancellable?.cancel()

    /** 実行結果:
     * 1
     * 2
     * 3
     */
}


/** sink(receiveCompletion:receiveValue:)
 * - receiveCompletionでPublisherが正常に終了したか、エラーで失敗したかの結果を受け取ることができます
 * - recieveValueでPublisherから要素を受け取った時に実行されます
 */

func sink(_ receiveCompletion: String, _ receiveValue: String) {
    var cancellable: AnyCancellable?
    let integers = [1, 2, 3]

    cancellable = integers.publisher.sink { completion in
        switch completion {
        case let .failure(never):
            print("Neverのため必ず実行されない: \(never)")

        case .finished:
            print("Finish.")
        }
    } receiveValue: { value in
        print(value)
    }
    cancellable?.cancel()

    /** 実行結果:
     * 1
     * 2
     * 3
     * Finish.
     */
}

/** assign(to:on:)
 * - Publisherから流れてくるデータをオブジェクトに代入できます
 * - to: どのプロパティ
 * - on: どのオブジェクト
 */

final class Assign {
    var value: Int = 0 {
        didSet {
            print("set: \(value)")
        }
    }

    // let toAssign = ToAssign()
    // toAssign.executeAssign()

    /** 実行結果:
     * set: 1
     * set: 2
     * set: 3
     */
}

final class ToAssign {
    let assign = Assign()
    let assignValue = [1, 2, 3]

    var cancellable: AnyCancellable?

    func executeAssign() {
        cancellable = assignValue.publisher.assign(to: \.value, on: assign)
        cancellable?.cancel()
    }
}
