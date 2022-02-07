import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class SocketData {
    public var km: Int

    public init(km: Int) {
        self.km = km
    }
}

public class SocketBus {
    public let subject: CurrentValueSubject<SocketData?, Never>
    public var timer: Timer?
    private var index = 0
    private let stataicData: [SocketData?] = [
        SocketData(km: 10),
        SocketData(km: 20),
        SocketData(km: 30),
        nil,
        SocketData(km: 40),
        nil,
        SocketData(km: 70),
        nil
    ]

    public init() {
        subject = CurrentValueSubject<SocketData?, Never>(SocketData.init(km: 0))
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
            guard self.stataicData.count > self.index else {
                self.subject.send(completion: .finished)
                timer.invalidate()
                return
            }

            self.subject.send(self.stataicData[self.index])
            self.index += 1
        })
    }

}
