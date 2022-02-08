import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "first(where: )") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.first{
        $0.hasSuffix("t")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "first(where: ) not exist") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.first{
        $0.hasSuffix("z")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "last(where: )") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.last{
        $0.hasSuffix("t")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "last(where: ) exist") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.last{
        $0.hasSuffix("z")
    }.sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}
