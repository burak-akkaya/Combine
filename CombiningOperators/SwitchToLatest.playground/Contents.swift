import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "switchToLatest") {

    let dataProducer = DataProducer()

    dataProducer.publishers.switchToLatest().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)

    dataProducer.sendData()
}

sample(of: "switchToLatest - Network Request") {
    let url = URL(string: "https://source.unsplash.com/random")!

    func getImage(_ value: String) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .print(value)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    let taps = PassthroughSubject<String, Never>()

    taps
        .map { value in getImage(value) }
        .switchToLatest()
        .sink(receiveValue: { _ in })
        .store(in: &subscriptions)

    taps.send("Image1")

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        taps.send("Image2")
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
        taps.send("Image3")
    }
}
