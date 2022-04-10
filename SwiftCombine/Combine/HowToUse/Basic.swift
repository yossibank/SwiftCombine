import Combine
import Foundation

/** 基礎編
 * Combineの基礎編としてまずは以下の３つのPublisher(値の発行者)について確認していきます
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

    /** CurrentValueSubject
     * 1つの値をラップしてその値が変更されるたびに新しい要素を公開するSubject
     * Combine側で値を保持したい時に利用します。
     */
    private var currentCancellable: AnyCancellable?

    /* Subject(Publisher)の定義*/
    private let currentSubject = CurrentValueSubject<[Int], Never>([]) // Neverはエラーを発生させない

    func executeCurrentSubject() {
        /* sinkメソッドを使用してPublisherを購読する */
        currentCancellable = currentSubject.sink { print($0) }

        /* 値を送る */
        currentSubject.value.append(1)
        currentSubject.value.append(2)
        currentSubject.value.append(3)

        /* 購読をキャンセルすることでその後の処理(currentSubject.value.append(4))は実行させません */
        currentCancellable?.cancel()

        currentSubject.value.append(4)

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
    private var passthroughCancellable: AnyCancellable?

    /* Subject(Publisher)の定義*/
    private let passthroughSubject = PassthroughSubject<Int, Never>()

    func executePassthroughSubject() {
        /* sinkメソッドを使用してPublisherを購読する */
        passthroughCancellable = passthroughSubject.sink { completion in
            switch completion {
                case .finished:
                    print("finished")

                case .failure: // Neverはエラーを発生させないため本来は不要
                    print("failure")
            }
        } receiveValue: { value in
            print(value)
        }

        passthroughSubject.send(1)
        passthroughSubject.send(completion: .finished)

        /* completionを投げた後はSubjectに対してsendメソッドを投げても実行されません */
        passthroughSubject.send(2)

        passthroughCancellable?.cancel()

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
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
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
                .receive(on: DispatchQueue.main)
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
