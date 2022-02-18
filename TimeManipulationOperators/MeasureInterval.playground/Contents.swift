import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Measure") {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher
    let measurePublisher = dataProducer.measurePublisher

    publisher.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value: ", value.description)
    }.store(in: &subscriptions)

    measurePublisher.sink { completion in
        print("Completed Measured Completion: ", completion)
    } receiveValue: { value in
        print("Received Measured Value: ", value)
    }.store(in: &subscriptions)


    dataProducer.publish()
}


sample(of: "Measure-2", delay: 15.0) {
    let dataProducer = DataProducer()
    let publisher = dataProducer.publisher
    let measurePublisher = dataProducer.measurePublisher
    
    publisher.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Value: ", value.description)
    }.store(in: &subscriptions)

    measurePublisher.sink { completion in
        print("Completed Measured Completion: ", completion)
    } receiveValue: { value in
        print("Received Measured Value: ", value)
    }.store(in: &subscriptions)

    dataProducer.sendData()
}
