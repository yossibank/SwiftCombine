import Combine
import Foundation

// MARK: - 「Future」

/** Future
 * 1つの値を非同期で生成して出力するか、失敗するPublisherです。
 * 「Aの処理が完了したらBの処理を実行する」という、これまで通信処理などで利用していたコールバック処理に使用できます。
 *
 * 例) 「20までカウントアップしたら特定の処理を実行する」というメソッドを作成します
 */

final class FutureViewModel: ViewModel {
    @Published var count = 0

    private var cancellables: Set<AnyCancellable> = .init()

    private let endCount = 20

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
