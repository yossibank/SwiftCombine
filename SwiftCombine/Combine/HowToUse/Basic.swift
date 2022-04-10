import Combine

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

/** CurrentValueSubject
 * 1つの値をラップしてその値が変更されるたびに新しい要素を公開するSubject
 * Combine側で値を保持したい時に利用します。
 */
var currentCancellable: AnyCancellable?

/* Subject(Publisher)の定義*/
let currentSubject = CurrentValueSubject<[Int], Never>([]) // Neverはエラーを発生させない

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
var passthroughCancellable: AnyCancellable?

/* Subject(Publisher)の定義*/
let passthroughSubject = PassthroughSubject<Int, Never>()

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
