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

    private var data: [UploadRate] = [
        UploadRate(rate: 1),
        UploadRate(rate: 2),
        UploadRate(rate: 5),
        UploadRate(rate: 12),
        UploadRate(rate: 18),
        UploadRate(rate: 727),
        UploadRate(rate: 912),
        UploadRate(rate: 1131),
        UploadRate(rate: 1442),
        UploadRate(rate: 1921)
    ]

    public init() {
        subject = PassthroughSubject<UploadRate, Never>()
    }

    private func sendValue(atIndex index: Int, delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.subject.send(self.data[index])
        }
    }

    public func send() {
        sendValue(atIndex: 0, delay: 0.3)
        sendValue(atIndex: 1, delay: 0.4)
        sendValue(atIndex: 2, delay: 1.0)
        sendValue(atIndex: 3, delay: 1.2)
        sendValue(atIndex: 4, delay: 2.0)
        sendValue(atIndex: 5, delay: 3.0)
        sendValue(atIndex: 6, delay: 3.4)
    }
}
