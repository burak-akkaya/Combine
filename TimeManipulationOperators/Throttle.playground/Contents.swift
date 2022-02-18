import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Throttle Values latest is false") {
    let networkManager = NetworkManager()
    let publisher = networkManager.ratePublisher
    publisher.throttle(for: 0.5, scheduler: DispatchQueue.main, latest: false).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Rate: ", value.rate)
    }.store(in: &subscriptions)

    networkManager.send()
}

sample(of: "Throttle Values latest is true", delay: 5.0) {
    let networkManager = NetworkManager()
    let publisher = networkManager.ratePublisher
    publisher.throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Rate: ", value.rate)
    }.store(in: &subscriptions)

    networkManager.send()
}
