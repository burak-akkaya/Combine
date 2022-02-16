import Foundation
import Combine

public func sample(of description: String, delay: TimeInterval = 0.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        print("\n----Sample of:", description, "----")
        action()
    }
}

public extension Date {
    init?(withString string:String, format:String = "dd/MM/yyyy HH:mm") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: string) else { return nil}
        self = date
    }
}
public struct MatchInfo: Comparable {
    private var matchDate: String
    private var stadium: String

    public init(matchDate: String, stadium: String) {
        self.matchDate = matchDate
        self.stadium = stadium
    }

    public var description: String {
        return String(format: "%@, %@, %d' ", matchDate, stadium)
    }

    public static func < (lhs: MatchInfo, rhs: MatchInfo) -> Bool {
        guard let lhsDate = Date(withString: lhs.matchDate), let rhsDate = Date(withString: rhs.matchDate) else { return false }

        return lhsDate < rhsDate
    }
}
public class DataProducer {
    private var subject: PassthroughSubject<MatchInfo, Never>

    public lazy var publisher: AnyPublisher<MatchInfo, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()


    var info = [
        MatchInfo(matchDate: "01/08/2022 19:00", stadium: "Old Trafford"),
        MatchInfo(matchDate: "01/08/2022 19:30", stadium: "Bernabeu"),
        MatchInfo(matchDate: "03/08/2022 19:00", stadium: "San Siro"),
        MatchInfo(matchDate: "04/08/2022 19:00", stadium: "Etihad" ),
        MatchInfo(matchDate: "05/08/2022 20:00", stadium: "Rome"),
        MatchInfo(matchDate: "05/08/2022 19:00", stadium: "Trabzon"),
    ]

    var timer: Timer?
    var index: Int = 0

    public init(delay: TimeInterval = 0.0) {
        subject = PassthroughSubject<MatchInfo, Never>()

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.startTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
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
