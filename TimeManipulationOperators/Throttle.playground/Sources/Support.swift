import Foundation
import Combine

public func sample(of description: String, delay: TimeInterval = 0.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        print("\n----Sample of:", description, "----")
        action()
    }
}



public class UploadRate {
    public var rate: Int

    init(rate: Int){
        self.rate = rate
    }
}

public func average(of rates: [UploadRate]) -> Int {
    let totalRates = rates.map { uploadRate -> Int in
        uploadRate.rate
    }.reduce(0, +)

    return totalRates / rates.count
}

public class NetworkManager {
    private var subject: PassthroughSubject<UploadRate, Never>

    public lazy var ratePublisher: AnyPublisher<UploadRate, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    private var timer: Timer?

    public init() {
        subject = PassthroughSubject<UploadRate, Never>()
    }

    private func send(value: UploadRate, delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.subject.send(value)
        }
    }

    public func send() {
        send(value: UploadRate(rate: 1), delay: 0.1)
        send(value: UploadRate(rate: 2), delay: 0.6)
        send(value: UploadRate(rate: 3), delay: 0.7)
        send(value: UploadRate(rate: 4), delay: 0.9)
        send(value: UploadRate(rate: 5), delay: 1.6)
        send(value: UploadRate(rate: 6), delay: 1.7)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.subject.send(completion: .finished)
        }
    }
}
