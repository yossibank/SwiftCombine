import Combine

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

final class JustViewModel: ViewModel {
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
