import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class Match: Equatable {
    public var matchID: String
    public var homeTeam: TeamScore
    public var awayTeam: TeamScore
    public var minutes: Int = 0

    public init(matchID:String, homeTeam: TeamScore, awayTeam: TeamScore, minutes: Int = 0) {
        self.matchID = matchID
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.minutes = minutes
    }

    public var description: String {
        return String(format: "%d' %@ %d - %d %@", minutes, homeTeam.name, homeTeam.score, awayTeam.score, awayTeam.name)
    }

    public static func ==(lhs: Match, rhs: Match) -> Bool{
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

public class ScoreListener {
    private var subject = PassthroughSubject<Match, Never>()

    public lazy var publisher: AnyPublisher<Match, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    var scores = [
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 5),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 15),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 25),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 35),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0), minutes: 45),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1), minutes: 55),
        Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2), minutes: 65)
    ]

    private var index: Int = 0
    private var timer: Timer?

    public init(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            guard self.index < self.scores.count else {
                self.subject.send(completion: .finished)
                timer.invalidate()
                return
            }
            self.subject.send(self.scores[self.index])
            self.index += 1
        })
    }


}

public enum Event {
    case started
    case ended
}

public class MatchEvent {
    public var match: Match
    public var event: Event

    public init(match: Match, event: Event) {
        self.match = match
        self.event = event
    }
}

public class MatchEventListener {
    private var subject = PassthroughSubject<MatchEvent, Never>()

    public lazy var publisher: AnyPublisher<MatchEvent, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    var events = [
        MatchEvent(match: Match(matchID: "30", homeTeam: TeamScore(name: "Chelsea", score: 0),
                                awayTeam: TeamScore(name: "Arsenal", score: 0)),
                   event: .started),
        MatchEvent(match: Match(matchID: "20", homeTeam: TeamScore(name: "Man Utd", score: 0),
                                awayTeam: TeamScore(name: "Man City", score: 0)),
                   event: .started),
        MatchEvent(match: Match(matchID: "40", homeTeam: TeamScore(name: "Liverpool", score: 0),
                                awayTeam: TeamScore(name: "Barcelona", score: 0)),
                   event: .started)

    ]

    private var index: Int = 0
    private var timer: Timer?

    public init(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            guard self.index < self.events.count else {
                self.subject.send(completion: .finished)
                timer.invalidate()
                return
            }
            self.subject.send(self.events[self.index])
            self.index += 1
        })
    }
}
