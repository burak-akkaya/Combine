import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

sample(of: "Map") {
    let values = ["Combine", "SwiftUI", "Foundation", "UIKit"]

    let publisher = values.publisher

    publisher.map { $0.replaceVowels()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}

sample(of: "Map with PassthroughSubject") {
    let subject = PassthroughSubject<String, Never>()
    let publisher = subject.eraseToAnyPublisher()

    publisher.map { $0.replaceVowels()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)

    subject.send("Steve Jobs")
    subject.send("Elon Musk")
    subject.send(completion: .finished)
    subject.send("Burak Akkaya")
}

sample(of: "Map with PassthroughSubject Complete With Error") {
    let subject = PassthroughSubject<String, DataError>()
    let publisher = subject.eraseToAnyPublisher()

    publisher.map { $0.replaceVowels()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)

    subject.send("Steve Jobs")
    subject.send("Elon Musk")
    subject.send(completion: .failure(DataError()))
}


sample(of: "Map with CurrentValueSubject") {
    let subject = CurrentValueSubject<String, Never>("")
    let publisher = subject.eraseToAnyPublisher()

    publisher.map { $0.replaceVowels()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)

    subject.send("Steve Jobs")
    subject.send("Elon Musk")
    subject.send(completion: .finished)
    subject.send("Burak Akkaya")

    print("Current Value of Subject: ", subject.value)
}

sample(of: "Map with CurrentValueSubject Complete With Failure") {
    let subject = CurrentValueSubject<String, DataError>("")
    let publisher = subject.eraseToAnyPublisher()

    publisher.map { $0.replaceVowels()}
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)

    subject.send("Steve Jobs")
    subject.send("Elon Musk")
    subject.send(completion: .failure(DataError()))

    print("Current Value of Subject: ", subject.value)
}

sample(of: "Map with fields") {
    let subject = PassthroughSubject<User, Never>()
    let publisher = subject.eraseToAnyPublisher()

    publisher.map(\.company)
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Company NameSu: ", $0)
    }.store(in: &subscriptions)

    subject.send(User(name: "Elon", surname: "Musk", company: "Tesla"))
    subject.send(User(name: "Steve", surname: "Jobs", company: "Apple"))
    subject.send(completion: .finished)
}
