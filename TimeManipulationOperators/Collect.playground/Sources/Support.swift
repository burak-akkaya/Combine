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

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            let rate = Int.random(in: 1...100)
            self.subject.send(UploadRate(rate: rate))
        })
    }
}
