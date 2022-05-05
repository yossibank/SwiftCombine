import UIKit

// MARK: - properties & init

final class Navigationbutton: UIButton {
    private let buttonSize: CGSize = .init(width: 40, height: 40)

    init(title: String) {
        super.init(frame: .init(origin: .zero, size: buttonSize))
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - override methods

extension Navigationbutton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEndAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation()
    }
}


// MARK: - private methods

private extension Navigationbutton {
    func touchStartAnimation() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.alpha = 0.7
            }
        )
    }

    func touchEndAnimation() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.alpha = 1.0
            }
        )
    }
}
