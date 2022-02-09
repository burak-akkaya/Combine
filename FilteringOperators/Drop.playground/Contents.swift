import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "dropFirst") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.dropFirst(3)
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "drop(while:)") {
    let values: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]

    let publisher = values.publisher

    publisher.drop(while: { $0 < 3})
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value)
        }.store(in: &subscriptions)
}

sample(of: "drop(untilOutputFrom: )") {
    let scoreListener = ScoreListener()
    let fixtureListener = MatchEventListener()

    let publisher = scoreListener.publisher
    let publisher2 = fixtureListener.publisher

    publisher.drop(untilOutputFrom: publisher2)
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value.description)
    }.store(in: &subscriptions)
}

sample(of: "drop(untilOutputFrom: ) exact match") {
    let scoreListener = ScoreListener()
    let fixtureListener = MatchEventListener()

    let publisher = scoreListener.publisher
    let publisher2 = fixtureListener.publisher

    publisher.drop(untilOutputFrom: publisher2.filter({ $0.match.matchID == "20"}))
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value.description)
        }.store(in: &subscriptions)
}
