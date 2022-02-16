import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "all satisfy false") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.allSatisfy{ $0 > 0}.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "contains true") {
    let values = [3, 4, 7, 8, 12]
    let publisher = values.publisher

    publisher.allSatisfy{ $0 > 0}.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}
