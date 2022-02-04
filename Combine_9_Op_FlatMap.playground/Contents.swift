import Combine
import Foundation
import Darwin

var subscriptions = Set<AnyCancellable>()

sample(of: "flatMap") {
    func find(key: String) -> AnyPublisher<Int, Never> {
        let dict = ["SwiftUI":14, "Foundation": 12, "Combine":13]
        return Just(dict[key]!).eraseToAnyPublisher()
    }

    let values = ["SwiftUI", "Foundation", "Combine"]
    let publisher1 = values.publisher

    publisher1.flatMap(find)
        .sink { completion in
        print("Completed: ", completion)
    } receiveValue: {
        print("Received Value: ", $0)
    }.store(in: &subscriptions)
}
let scoreListener = ScoreListener()

sample(of: "flatMap with Subjects") {
    scoreListener.publisher
        .sink { completion in
            print("Completed Score: ", completion)
        } receiveValue: {
            print("Score: ",$0.toString())
        }.store(in: &subscriptions)
}

let webService = WebService()
scoreListener.publisher.flatMap({ score in
    return webService.getStats(id: score.matchID, minutes: score.minutes)
}).sink { completion in
    print("Completed Stat: ", completion)
} receiveValue: {
    print("Stat: ", $0.toString())
}.store(in: &subscriptions)

let seconds = 1.0
DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    scoreListener.publisher.flatMap({ score in
        return webService.getStats(id: score.matchID, minutes: score.minutes)
    }).sink { completion in
        print("Completed Stat With Delay: ", completion)
    } receiveValue: {
        print("Stat with Delay: ", $0.toString())
    }.store(in: &subscriptions)

}


