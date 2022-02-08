import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "ignoreOutput") {
    let values: [String] = ["a", "1.24", "3", "def", "45"]

    let publisher = values.publisher

    publisher.ignoreOutput().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "ignoreOutput & replaceEmpty") {
    let values: [String] = ["a", "1.24", "3", "def", "45"]

    let publisher = values.publisher

    publisher.ignoreOutput()
        .replaceEmpty(with: "Empty")
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "ignoreOutput & collect") {
    let values: [String] = ["a", "1.24", "3", "def", "45"]

    let publisher = values.publisher

    publisher.ignoreOutput()
        .collect()
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value)
        }.store(in: &subscriptions)
}

