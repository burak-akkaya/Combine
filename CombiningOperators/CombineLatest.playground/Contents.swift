import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "CombineLatest") {
    let numbers = [1, 5, 6, 7, 9]
    let texts = ["iOS", "Android", "DevOps"]

    let publisher1 = numbers.publisher
    let publisher2 = texts.publisher

    publisher1.combineLatest(publisher2)
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "CombineLatest-2") {
    let matchScoreSocket = MatchScoreWebSocket()
    let matchInfoSocket = MatchInfoWebSocket()

    let scorePublisher = matchScoreSocket.publisher
    let infoSocket = matchInfoSocket.publisher

    infoSocket.combineLatest(scorePublisher)
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value, value2 in
            print("Received Values:" , value.description, value2.description)
        }.store(in: &subscriptions)
}

