import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Debounce Values") {
    let networkManager = NetworkManager()
    let publisher = networkManager.ratePublisher
    publisher.debounce(for: 0.4, scheduler: DispatchQueue.main).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Rate: ", value.rate)
    }.store(in: &subscriptions)

    networkManager.send()
}
