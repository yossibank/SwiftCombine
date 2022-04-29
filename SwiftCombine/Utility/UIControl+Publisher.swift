import Combine
import Foundation
import UIKit

extension UIControl {
    final class Subscription<
        SubscriberType: Subscriber,
        Control: UIControl
    >: Combine.Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let control: Control

        init(
            subscriber: SubscriberType,
            control: Control,
            event: UIControl.Event
        ) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(
                self,
                action: #selector(eventHandler),
                for: event
            )
        }

        func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }

        func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(control)
        }
    }

    struct Publisher<Control: UIControl>: Combine.Publisher {
        typealias Output = Control
        typealias Failure = Never

        let control: Control
        let controlEvents: UIControl.Event

        init(control: Control, events: UIControl.Event) {
            self.control = control
            self.controlEvents = events
        }

        func receive<S>(
            subscriber: S
        ) where S : Subscriber, Never == S.Failure, Control == S.Input {
            let subscription = Subscription(
                subscriber: subscriber,
                control: control,
                event: controlEvents
            )

            subscriber.receive(subscription: subscription)
        }
    }
}

protocol CombineCompatible {}

extension UIControl: CombineCompatible {}

extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControl.Publisher<Self> {
        UIControl.Publisher(control: self, events: events)
    }
}

extension CombineCompatible where Self: UISwitch {
    var isOnPublisher: AnyPublisher<Bool, Never> {
        publisher(for: [.allEditingEvents, .valueChanged]).map {
            $0.isOn
        }
        .eraseToAnyPublisher()
    }
}

extension CombineCompatible where Self: UISegmentedControl {
    var selectedIndexPublisher: AnyPublisher<Int, Never> {
        publisher(for: [.allEditingEvents, .valueChanged]).map {
            $0.selectedSegmentIndex
        }
        .eraseToAnyPublisher()
    }
}
