import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Collecting Values") {
    let networkManager = NetworkManager()
    let publisher = networkManager.ratePublisher
    let collectedPublisher = publisher.collect(.byTime(DispatchQueue.main, .seconds(5.0)))

    publisher.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Rate: ", value.rate)
    }.store(in: &subscriptions)

    collectedPublisher.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Values = ", values.map{$0.rate})
        print("\(Date.now) - Average Rate:" , average(of: values))
    }.store(in: &subscriptions)
}
