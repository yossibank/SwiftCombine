import UIKit

extension UIView {
    func addSubViews(
        _ views: UIView...,
        constraints: NSLayoutConstraint...
    ) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        constraints.forEach {
            $0.isActive = true
        }
    }

    func findConstraint(
        layoutAttribute: NSLayoutConstraint.Attribute
    ) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(
                constraint: constraint,
                layoutAttribute: layoutAttribute
            ) {
                return constraint
            }
        }

        return nil
    }

    func itemMatch(
        constraint: NSLayoutConstraint,
        layoutAttribute: NSLayoutConstraint.Attribute
    ) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self
            && constraint.firstAttribute == layoutAttribute

        let secondItemMatch = constraint.secondItem as? UIView == self
            && constraint.secondAttribute == layoutAttribute

        return firstItemMatch || secondItemMatch
    }
}
