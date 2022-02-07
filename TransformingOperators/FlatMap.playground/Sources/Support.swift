import Foundation
import Combine
public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public struct Score {
    public var matchID: String
    var homeTeam: String
    var awayTeam: String
    var homeScore: Int
    var awayScore: Int
    public var minutes: Int

    public init(matchID: String, homeTeam:String, awayTeam: String, homeScore: Int, awayScore: Int, minutes: Int) {
        self.matchID = matchID
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.minutes = minutes
    }

    public func toString() -> String {
        return String(format: "%@ %d - %d %@ , Minutes: %d", homeTeam, homeScore, awayScore, awayTeam, minutes)
    }
}

public class ScoreListener{
    var subject: PassthroughSubject<Score, Never>
    var timer: Timer?

    public init(){
        self.subject = PassthroughSubject()
        start()
    }

    public var publisher: AnyPublisher<Score, Never> {
        return subject.eraseToAnyPublisher()
    }

    var data: [Score] {
        return [
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 0, awayScore: 0, minutes: 0),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 0, awayScore: 0, minutes: 1),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 0, awayScore: 0, minutes: 2),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 0, awayScore: 0, minutes: 3),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 0, awayScore: 0, minutes: 4),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 1, awayScore: 0, minutes: 5),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 1, awayScore: 0, minutes: 15),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 1, awayScore: 1, minutes: 25),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 1, awayScore: 1, minutes: 35),
            Score(matchID: "12345", homeTeam: "Man Utd", awayTeam: "Man City", homeScore: 1, awayScore: 2, minutes: 45)
        ]
    }

    func start() {
        var dataIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [unowned self] _ in
            if dataIndex < self.data.count {
                self.subject.send(self.data[dataIndex])
            }else {
                self.subject.send(completion: .finished)
            }
            dataIndex+=1
        })
    }
}

public struct Stat {
    var name: String
    var value: String
    public var minutes: Int = 0

    public init(name:String, value:String) {
        self.name = name
        self.value = value
    }

    public func toString() -> String {
        return name + ": " + value + " - " + "Minutes: " + "\(minutes)"
    }
}

public class ServiceError: Error {

}

public class WebService{
    var db : [String: Stat] {
        return [
            "12345" : Stat(name: "Name1", value: "Value1"),
            "12346" : Stat(name: "Name2", value: "Value2"),
            "12347" : Stat(name: "Name3", value: "Value3"),
            "12348" : Stat(name: "Name4", value: "Value4")
        ]
    }

    public init() {}

    public func getStats(id: String, minutes: Int) -> AnyPublisher<Stat, ServiceError> {
        if var value = db[id] {
            value.minutes = minutes
            return Just(value).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
        }

        return Fail(error: ServiceError()).eraseToAnyPublisher()
    }

}
