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

public class DataProducer{
    private var subject = PassthroughSubject<Match, Never>()

    public lazy var publisher: AnyPublisher<Match, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    var scores:[Match]

    private var index: Int = 0
    private var timer: Timer?

    public init(scores: [Match], delay: TimeInterval){
        self.scores = scores

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
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
}
