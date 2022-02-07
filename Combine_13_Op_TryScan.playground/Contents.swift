import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Producer tryScan") {
    let producer = Producer()
    producer.publisher.tryScan(0){latest, current in
        print("lastValue: \(latest), currentValue: \(current)")
        let total = latest + current

        if total > 200{
            throw DataError()
        }
        return total
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}
