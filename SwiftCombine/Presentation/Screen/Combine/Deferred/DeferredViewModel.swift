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

final class DeferredViewModel: ViewModel {
    let futurePublisher = Future<String, Never> { promise in
        print("Future実行")
        promise(.success("Hello"))
    }

    let deferredPublisher = Deferred { () -> Just<String> in
        print("Deferred実行")
        return Just("Hello")
    }
}
