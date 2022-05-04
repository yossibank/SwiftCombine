import UIKit

class IndicatorViewController: UIViewController {
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(indicator)
    }
}

// MARK: - internal methods

extension IndicatorViewController {
    func startIndicator() {
        indicator.startAnimating()
    }

    func stopIndicator() {
        indicator.stopAnimating()
    }
}

// MARK: - private methods

private extension IndicatorViewController {
    func setupView() {
        view.addSubViews(
            indicator,

            constraints:
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        )
    }
}
