import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "min number") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.min().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Min Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "min text") {
    let values = ["Apple", "Strawberry", "Banana", "Watermelon"]
    let publisher = values.publisher

    publisher.min().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Min Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "max number") {
    let values = [-1, 3, 4, 7, 8, 12, -87]
    let publisher = values.publisher

    publisher.max().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Max Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "max text") {
    let values = ["Apple", "Strawberry", "Banana", "Watermelon"]
    let publisher = values.publisher

    publisher.max().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Max Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "min data") {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.min().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Min Value:" , value)
    }.store(in: &subscriptions)
}

sample(of: "max data", delay: 2) {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.max().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Max Value:" , value)
    }.store(in: &subscriptions)
}
