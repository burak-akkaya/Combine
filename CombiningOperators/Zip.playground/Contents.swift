import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "Zip") {
    let scoreSocket = MatchScoreWebSocket(period: 1)
    let infoSocket = MatchInfoWebSocket(period: 3)

    let scorePublisher = scoreSocket.publisher
    let infoPublisher = infoSocket.publisher

    scorePublisher.zip(infoPublisher).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { score, info in
        print("Received Values:" , info.description, score.description)
    }.store(in: &subscriptions)
}
