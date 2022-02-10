import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
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

public class ScoreSocket {
    private var subject = PassthroughSubject<MatchScore, Never>()

    public lazy var publisher: AnyPublisher<MatchScore, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    public var scores: [MatchScore]
    var timer: Timer?
    var index: Int = 0

    public init(scores: [MatchScore], period: TimeInterval) {
        self.scores = scores

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
