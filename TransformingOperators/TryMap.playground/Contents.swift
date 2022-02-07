import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Map") {
    let values = ["Combine", "SwiftUI", "Foundation", "UIKit"]

    let publisher = values.publisher

    publisher.map { try? $0.isGood()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}

sample(of: "tryMap") {
    let values = ["Combine", "SwiftUI", "Foundation", "UIKit"]
    let publisher = values.publisher

    publisher.tryMap { try $0.isGood()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}

sample(of: "tryMap") {
    let values = ["Combine", "Foundation", "UIKit"]
    let publisher = values.publisher

    publisher.tryMap { try $0.isGood()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}
