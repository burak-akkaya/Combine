import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

execute(of: "NotificationCenter") {
    let center = NotificationCenter.default
    let notification = Notification.Name("Notification")

    let publisher = center.publisher(for: notification, object: nil)

    let subscription = publisher.sink { _ in
        print("Notification received from a publisher!")
    }

    subscriptions.insert(subscription)

    center.post(name: notification, object: nil)
    subscription.cancel()
}



