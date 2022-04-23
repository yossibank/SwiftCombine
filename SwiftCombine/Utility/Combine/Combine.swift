import Combine

/**
 * Combineって何？
 * → イベントの発行と購読をすることができるApple公式の非同期フレームワーク
 * → 要は、あるイベントを出力したら好きなタイミングで値を受け取ることができる機能
 *
 * 役割
 * 1. Publisher: 値を提供する役割(発行者)
 * 2. Subscriber: Publisherが提供した値を購読する役割(購読者)
 * 3. Operator: Publisherが提供する値を受け取り、役割に応じて値を変化させてSubscriberに流す役割(中間管理職)
 *
 * 例) テレビ番組で表すと、それぞれの役割はこうなります
 *
 *   テレビ局(番組の配信)            テレビ(音量や色の調節)            視聴者(番組を見る人々)
 *  -----------------     →     -----------------     →     ------------------
 *  --- Publisher ---     →     --- Operator  ---     →     --- Subscriber ---
 *  -----------------     →     -----------------     →     ------------------
 *
 * 例) お菓子工場のベルトコンベアー
 *
 *   工場のベルトコンベアー           調理(混ぜる、焼く、煮る)          完成したお菓子を受け取る人
 *  -----------------     →     -----------------     →     ------------------
 *  --- Publisher ---     →     --- Operator  ---     →     --- Subscriber ---
 *  -----------------     →     -----------------     →     ------------------
 *
 * 何が良いのか？
 * → Swiftの特徴である、クロージャを使ったコールバックでコードの可読性が下がったり、
 * 処理が難しくなることを防ぎ、コードのメンテナンス性の向上が期待できます。
 *
 */