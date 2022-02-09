import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

sample(of: "prepend(Output...)") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.prepend("Jordan", "Hakeem")
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value)
        }.store(in: &subscriptions)
}

sample(of: "prepend(Sequence)") {
    let values: [String] = ["James", "Harden", "Steph", "Durant", "Wade", "Westbrook", "Davis", "Jokic", "Morant", "Fox"]

    let publisher = values.publisher

    publisher.prepend(["Jordan", "Hakeem"])
        .sink { completion in
            print("Completed: ", completion)
        } receiveValue: { value in
            print("Received Values:" , value)
        }.store(in: &subscriptions)
}


sample(of: "prepend(Publisher)") {
    let scores1 = [
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 5),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 15),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 25),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 35),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 45),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1), minutes: 55),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2), minutes: 65)
    ]

    let dataProducer1 = DataProducer(scores: scores1, delay: 2)

    let scores2 = [
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0), minutes: 5),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0), minutes: 15),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0), minutes: 25),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0), minutes: 35),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 0), minutes: 45),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 1), minutes: 55),
        Match(matchID: "20", homeTeam: TeamScore(name: "Chelsea", score: 0), awayTeam: TeamScore(name: "Liverpool", score: 2), minutes: 65)
    ]

    let dataProducer2 = DataProducer(scores: scores2, delay: 0)

    let publisher1 = dataProducer1.publisher
    let publisher2 = dataProducer2.publisher

    publisher1.prepend(publisher2).sink { completion in
        print("Completed: ", completion)
    } receiveValue: { value in
        print("Received Values:" , value.description)
    }.store(in: &subscriptions)
}
