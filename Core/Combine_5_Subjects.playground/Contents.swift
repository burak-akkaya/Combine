import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

execute(of: "PassthroughSubject") {

    let subject = PassthroughSubject<String, Never>()

    subject.sink(receiveCompletion: { _ in
        print("Completed")
    }, receiveValue: { value in
        print("Value Received: ", value)
    }).store(in: &subscriptions)

    subject.send("Combine PassthroughSubject")
    subject.send("Sample Value")
    subject.send(completion: .finished)
    subject.send("Still alive!")

}

execute(of: "CurrentValueSubject") {

    let subject = CurrentValueSubject<String, Never>("Initial Value")

    subject.sink(receiveCompletion: { _ in
        print("Completed")
    }, receiveValue: { value in
        print("Value Received: ", value)
    }).store(in: &subscriptions)

    subject.send("Combine CurrentValueSubject")
    subject.send("Sample Value")

    print("Last value: ", subject.value)
    subject.send(completion: .finished)

    subject.send("Still alive!")
    print("Last value: ", subject.value)
}

execute(of: "Type erasure") {
    let subject = PassthroughSubject<Int, Never>()

    let publisher = subject.eraseToAnyPublisher()

    subject.sink(receiveCompletion: { _ in
        print("Completed")
    }, receiveValue: { value in
        print("Value Received: ", value)
    }).store(in: &subscriptions)

    subject.send(0)
}
