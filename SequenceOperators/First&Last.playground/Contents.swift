import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "first number") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.first().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "first text") {
    let values = ["Apple", "Strawberry", "Banana", "Watermelon"]
    let publisher = values.publisher

    publisher.first().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "last number") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.last().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "last text") {
    let values = ["Apple", "Strawberry", "Banana", "Watermelon"]
    let publisher = values.publisher

    publisher.last().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "first data") {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.first().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "last data", delay: 2) {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.last().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value:" , value)
    }.store(in: &subscriptions)
}
