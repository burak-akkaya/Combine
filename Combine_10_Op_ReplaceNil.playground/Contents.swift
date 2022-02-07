import UIKit
import Combine

var greeting = "Hello, playground"

var subscriptions = Set<AnyCancellable>()

sample(of: "ReplaceNil") {
    let values: [String?] = ["Combine", "SwiftUI", "Foundation", "UIKit", nil]

    let publisher = values.publisher

    publisher.eraseToAnyPublisher().replaceNil(with: "-")
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: {
            print("Received Value: ", $0)
        }.store(in: &subscriptions)
}

// LastValid
sample(of: "ReplaceNil with Subjects") {
    let defaultValue: SocketData = SocketData(km: 0)
    let socketBus = SocketBus()

    socketBus.subject.eraseToAnyPublisher()
        .replaceNil(with: defaultValue)
        .sink { completion in
            print("Completed: ", completion)
            print("Last Value of Subject: ", socketBus.subject.value?.km ?? "Nil")
        } receiveValue: {
            defaultValue.km = $0.km
            print("Received Value: ", $0.km)
        }.store(in: &subscriptions)
}
