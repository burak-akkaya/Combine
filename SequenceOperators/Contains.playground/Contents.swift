import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "contains true") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.contains(4).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "contains false") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.contains(24).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}
