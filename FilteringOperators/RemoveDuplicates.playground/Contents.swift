import Foundation
import Combine


var subscriptions = Set<AnyCancellable>()

sample(of: "removeDuplicates") {
    let values = [1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 9, 10]

    let publisher = values.publisher

    publisher.removeDuplicates()
    .sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value)
    }.store(in: &subscriptions)
}

sample(of: "removeDuplicates") {
    let values = [1, 1, 3, 4, 5, 6, 6, 8, 9, 10]

    let publisher = values.publisher

    publisher.removeDuplicates()
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value)
        }.store(in: &subscriptions)
}

sample(of: "removeDuplicates on Object") {
    let scores = [
        Score(homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2))
    ]

    let publisher = scores.publisher

    publisher.removeDuplicates()
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value.description)
        }.store(in: &subscriptions)
}

sample(of: "removeDuplicates on Subject") {

    let scoreListener = ScoreListener()
    let publisher = scoreListener.publisher

    publisher
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value.description)
        }.store(in: &subscriptions)
}

