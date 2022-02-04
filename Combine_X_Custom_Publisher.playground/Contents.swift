
import Foundation
import Combine

var subscription: AnyCancellable!

execute(of: "Subscribe to publisher") {
    let publisher = IntPublisher()

    subscription = publisher.sink { _ in
        print("Completed")
        subscription.cancel()
    } receiveValue: { value in
        print("Received value: \(value)")
    }
}
