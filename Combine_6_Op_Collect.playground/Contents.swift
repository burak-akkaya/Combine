import Foundation
import Combine


var subscriptions = Set<AnyCancellable>()

sample(of: "Collect - Array") {
    let values = ["Burak", "Akkaya", "20/08/1991", "Trabzon"]
    let publisher = values.publisher
    publisher.collect().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Received Values:" , values)
    }.store(in: &subscriptions)
}


sample(of: "Collect - Subject") {
    let subject = PassthroughSubject<String, Never>()
    let values = ["Burak", "Akkaya", "20/08/1991", "Trabzon"]
    let publisher = subject.eraseToAnyPublisher()

    publisher.collect().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Received Values:" , values)
    }.store(in: &subscriptions)

    for value in values {
        subject.send(value)
    }

    subject.send(completion: .finished)
}

sample(of: "Collect - Subject Completed With Error") {
    let subject = PassthroughSubject<String, DataError>()
    let values = ["Burak", "Akkaya", "20/08/1991", "Trabzon"]
    let publisher = subject.eraseToAnyPublisher()

    publisher.collect().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Received Values:" , values)
    }.store(in: &subscriptions)

    for value in values {
        subject.send(value)
    }

    subject.send(completion: .failure(DataError()))
}

sample(of: "Subject Completed With Error") {
    let subject = PassthroughSubject<String, DataError>()
    let values = ["Burak", "Akkaya", "20/08/1991", "Trabzon"]
    let publisher = subject.eraseToAnyPublisher()

    publisher.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Received Values:" , values)
    }.store(in: &subscriptions)

    for value in values {
        subject.send(value)
    }

    subject.send(completion: .failure(DataError()))
}

sample(of: "CurrentValueSubject Subject Completed With Error") {
    let subject = CurrentValueSubject<String, DataError>("")
    let values = ["Burak", "Akkaya", "20/08/1991", "Trabzon"]
    let publisher = subject.eraseToAnyPublisher()

    publisher.collect().sink { completion in
        print("Completed: ", completion)
    } receiveValue: { values in
        print("Received Values:" , values)
    }.store(in: &subscriptions)

    for value in values {
        subject.send(value)
    }

    subject.send(completion: .failure(DataError()))

    print("Current Value of Subject: ", subject.value)
}
