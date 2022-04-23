import Combine
import Foundation

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
