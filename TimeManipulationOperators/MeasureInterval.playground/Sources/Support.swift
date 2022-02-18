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

public enum DataProducerError: Error {
    case timeout
}


public class DataProducer {
    private var subject: PassthroughSubject<MatchInfo, DataProducerError>

    public lazy var measurePublisher: AnyPublisher<DispatchQueue.SchedulerTimeType.Stride, DataProducerError> = {
        let instance = subject.measureInterval(using: DispatchQueue.main).eraseToAnyPublisher()
        return instance
    }()

    public lazy var publisher: AnyPublisher<MatchInfo, DataProducerError> = {
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

    public init() {
        subject = PassthroughSubject<MatchInfo, DataProducerError>()
    }

    public func publish() {
        self.startTimer()
    }

    private func sendValue(atIndex index: Int, delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.subject.send(self.info[index])
        }
    }

    public func sendData() {
        sendValue(atIndex: 0, delay: 0.3)
        sendValue(atIndex: 1, delay: 0.4)
        sendValue(atIndex: 2, delay: 1.0)
        sendValue(atIndex: 3, delay: 1.2)
        sendValue(atIndex: 4, delay: 2.0)
        sendValue(atIndex: 5, delay: 3.0)
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: true, block: { timer in
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
