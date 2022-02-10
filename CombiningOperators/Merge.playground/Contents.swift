import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()


sample(of: "merge") {
    let scores = [
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2))
    ]

    let scores2 = [
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 1), awayTeam: TeamScore(name: "Liverpool", score: 0)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 1), awayTeam: TeamScore(name: "Liverpool", score: 0)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 1), awayTeam: TeamScore(name: "Liverpool", score: 0)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 1), awayTeam: TeamScore(name: "Liverpool", score: 1)),
        MatchScore(matchID: "21", homeTeam: TeamScore(name: "Chelsea", score: 1), awayTeam: TeamScore(name: "Liverpool", score: 2))
    ]

    let socket1 = ScoreSocket(scores: scores, period: 0.5)
    let socket2 = ScoreSocket(scores: scores2, period: 1.0)

    let publisher1 = socket1.publisher
    let publisher2 = socket2.publisher

    publisher1.merge(with: publisher2).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value.description)
    }.store(in: &subscriptions)
}
