import UIKit
import Combine


var subscriptions = Set<AnyCancellable>()

func get(value: Int) -> AnyPublisher<SocketData, Never> {
    if value == 0 {
        return Empty(completeImmediately: true, outputType: SocketData.self, failureType: Never.self).eraseToAnyPublisher()
    }
    let socketData = SocketData(km: value)
    return Just(socketData).setFailureType(to: Never.self).eraseToAnyPublisher()
}

sample(of: "ReplaceEmpty") {
    get(value: 10).replaceEmpty(with: SocketData(km: 1))
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: {
            print("Received Value: ", $0.km)
        }.store(in: &subscriptions)
}

sample(of: "ReplaceEmpty - 2") {
    get(value: 0).replaceEmpty(with: SocketData(km: 1))
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: {
            print("Received Value: ", $0.km)
        }.store(in: &subscriptions)
}
