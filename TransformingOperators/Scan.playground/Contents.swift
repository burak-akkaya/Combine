import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Scan") {
    let values = (0...20)

    let publisher = values.publisher

    publisher.scan(0){latest, current in
        print("lastValue: \(latest), currentValue: \(current)")
        let total = latest + current
        return total
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}

sample(of: "Producer Scan") {
    let producer = Producer()
    producer.publisher.scan(0){latest, current in
        print("lastValue: \(latest), currentValue: \(current)")
        let total = latest + current
        return total
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}


