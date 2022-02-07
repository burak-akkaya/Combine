import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

execute(of: "Sink") {
    let just = Just("Hello World").setFailureType(to: Error.self)

    just.sink { completion in
        switch completion {
        case .finished:
            print("Received Completion: Finished")
        case .failure(let error):
            print("Received Completion: Error ", error.localizedDescription)
        }
    } receiveValue: { value in
        print("Received Value: ", value)
    }.store(in: &subscriptions)
}
