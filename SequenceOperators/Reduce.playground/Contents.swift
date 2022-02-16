import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "reduce number") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.reduce(0){total, value in
        total + value
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "reduce text") {
    let values = ["Apple", "Huawei", "Samsung", "Xiaomi"]
    let publisher = values.publisher

    publisher.reduce("Brands: "){last, value in
        last + value + ", "
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}
