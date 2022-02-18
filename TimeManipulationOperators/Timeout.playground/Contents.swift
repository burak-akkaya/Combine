import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Timeout-1") {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.timeout(.seconds(2.0), scheduler: DispatchQueue.main) {
        .timeout
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value: ", value.description)
    }.store(in: &subscriptions)

    dataProducer.publish()
}

sample(of: "Timeout-2", delay: 15.0) {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher

    publisher.timeout(.seconds(0.8), scheduler: DispatchQueue.main) {
        .timeout
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value: ", value.description)
    }.store(in: &subscriptions)

    dataProducer.sendData()
}
