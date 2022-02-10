import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public struct MatchInfo {
    private var matchDate: String
    private var stadium: String
    private var minutes: Int

    public init(matchDate: String, stadium: String, minutes: Int) {
        self.matchDate = matchDate
        self.stadium = stadium
        self.minutes = minutes
    }

    public var description: String {
        return String(format: "%@, %@, %d' ", matchDate, stadium, minutes)
    }
}


public class MatchScore: Equatable {
    public var matchID: String
    public var homeTeam: TeamScore
    public var awayTeam: TeamScore

    public init(matchID:String, homeTeam: TeamScore, awayTeam: TeamScore) {
        self.matchID = matchID
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }

    public var description: String {
        return String(format: " %@ %d - %d %@", homeTeam.name, homeTeam.score, awayTeam.score, awayTeam.name)
    }

    public static func ==(lhs: MatchScore, rhs: MatchScore) -> Bool{
        return lhs.homeTeam == rhs.homeTeam && lhs.awayTeam == rhs.awayTeam && lhs.matchID == rhs.matchID
    }
}

public class TeamScore: Equatable{
    public var name: String
    public var score: Int

    public init(name: String, score: Int) {
        self.name = name
        self.score = score
    }

    public static func == (lhs: TeamScore, rhs: TeamScore) -> Bool {
        return lhs.name == rhs.name && lhs.score == rhs.score
    }
}

public class MatchInfoWebSocket {
    private var subject = PassthroughSubject<MatchInfo, Never>()

    public lazy var publisher: AnyPublisher<MatchInfo, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    var info = [
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 1),
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 2),
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 3),
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 4),
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 5),
        MatchInfo(matchDate: "20/08/2022 19:00", stadium: "Old Trafford", minutes: 6),
    ]

    var index: Int = 0
    var timer: Timer?

    public init(period: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: { timer in
            guard self.index < self.info.count else {
                timer.invalidate()
                self.subject.send(completion: .finished)
                return
            }

            self.subject.send(self.info[self.index])
            self.index += 1
        })
    }
}

public class MatchScoreWebSocket {
    private var subject = PassthroughSubject<MatchScore, Never>()

    public lazy var publisher: AnyPublisher<MatchScore, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    var scores = [
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1)),
        MatchScore(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2))
    ]

    var index: Int = 0
    var timer: Timer?

    public init(period: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: { timer in
            guard self.index < self.scores.count else {
                timer.invalidate()
                self.subject.send(completion: .finished)
                return
            }

            self.subject.send(self.scores[self.index])
            self.index += 1
        })
    }
}

