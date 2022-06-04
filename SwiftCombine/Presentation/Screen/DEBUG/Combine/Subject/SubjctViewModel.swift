import Combine

// MARK: - 「Subject」

/** Subject
 * 一般的なPublisherはイベントが流れてくるだけのものです。
 * ただ、「Subject」はsend(_:)メソッドを呼び出すことにより、意図的に値を注入することができるPublisherです。
 * 「Subject」には2つの種類があります。
 *  1. CurrentValueSubject
 *  2. PassthroughSubject
 */

final class SubjectViewModel: ViewModel {
    /** CurrentValueSubject
     * 1つの値をラップしてその値が変更されるたびに新しい要素を公開するSubject
     * Combine側で値を保持したい時に利用します。
     */

    /* Subject(Publisher)の定義*/
    let currentSubject = CurrentValueSubject<[Int], Never>([]) // Neverはエラーを発生させない

    /** PassthroughSubject
     * 異なる値を保持しないSubject
     * 値を保持する必要がなく毎回データを更新(上書き)する時に利用します。
     */

    /* Subject(Publisher)の定義*/
    let passthroughSubject = PassthroughSubject<Int, Never>()

    /* 複数のAnyCancellable(イベントの購読をキャンセル処理)を一括で管理 */
    private var cancellables: Set<AnyCancellable> = .init()

    func executeCurrentSubject() {
        /* sinkメソッドを使用してPublisherを購読する */
        currentSubject.sink {
            print($0)
        }
        .store(in: &cancellables)

        /* 値を送る */
        currentSubject.value.append(1)
        currentSubject.value.append(2)
        currentSubject.value.append(3)

        /* 処理が終了したことを伝える */
        currentSubject.send(completion: .finished)

        /* completionを投げた後はSubjectに対してsendメソッドを投げても実行されません */
        currentSubject.value.append(4)
    }

    func executePassthroughSubject() {
        /* sinkメソッドを使用してPublisherを購読する */
        passthroughSubject.sink { completion in
            switch completion {
                case .finished:
                    print("finished")

                case .failure: // Neverはエラーを発生させないため本来は不要
                    print("failure")
            }
        } receiveValue: {
            print($0)
        }
        .store(in: &cancellables)

        /* 値を送る */
        passthroughSubject.send(1)

        /* 処理が終了したことを伝える */
        passthroughSubject.send(completion: .finished)

        /* completionを投げた後はSubjectに対してsendメソッドを投げても実行されません */
        passthroughSubject.send(2)
    }
}
