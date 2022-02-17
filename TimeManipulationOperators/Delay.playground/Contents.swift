import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Delay") {
    let values = [1, 2, 3, 4, 5, 6, 7]
    let publisher = values.publisher
    print(Date.now)
    publisher.delay(for: .seconds(5), scheduler: DispatchQueue.main).sink { completion in
        print("Completed: ", completion)
        print(Date.now)
    } receiveValue: { value in
        print("Received Min Value:" , value)
    }.store(in: &subscriptions)
}
