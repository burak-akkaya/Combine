import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "compactMap") {
    let values: [String] = ["a", "1.24", "3", "def", "45"]

    let publisher = values.publisher

    publisher.compactMap{Float($0)}.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "compactMap") {
    let values: [Int?] = [1, 2, 3, nil, 5, 6, 7, 8, nil, 10]

    let publisher = values.publisher

    publisher.compactMap{$0}.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}
