import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "output(at:)") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.output(at:3).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "output(in:)") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.output(in: 1...3).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}
