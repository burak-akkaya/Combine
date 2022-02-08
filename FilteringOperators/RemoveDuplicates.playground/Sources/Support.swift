import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class Score: Equatable {
    public var homeTeam: TeamScore
    public var awayTeam: TeamScore

    public init(homeTeam: TeamScore, awayTeam: TeamScore) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }

    public var description: String {
        return String(format: "%@ %d - %d %@", homeTeam.name, homeTeam.score, awayTeam.score, awayTeam.name)
    }

    public static func ==(lhs: Score, rhs: Score) -> Bool{
        return lhs.homeTeam == rhs.homeTeam && lhs.awayTeam == rhs.awayTeam
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
    private var subject: PassthroughSubject<Score, Never>
    private var internalSubject: PassthroughSubject<Score, Never>
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public lazy var publisher: AnyPublisher<Score, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()
    var scores = [
        Score(homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 0), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 0)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 1)),
        Score(homeTeam: TeamScore(name: "Man Utd", score: 1), awayTeam: TeamScore(name: "Man City", score: 2))
    ]
    private var index: Int = 0
    private var timer: Timer?

    public init() {
        subject = PassthroughSubject<Score, Never>()
        internalSubject = PassthroughSubject<Score, Never>()
        listenInternal()

        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
            guard self.index < self.scores.count else {
                self.internalSubject.send(completion: .finished)
                timer.invalidate()
                return
            }
            self.internalSubject.send(self.scores[self.index])
            self.index += 1
        })
    }

    private func listenInternal() {
        self.internalSubject.removeDuplicates()
            .sink { completion in
                self.subject.send(completion: completion)
            } receiveValue: { value in
                self.subject.send(value)
            }.store(in: &subscriptions)
    }
}
