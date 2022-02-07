import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class DataError: Error{
    public init() {}
}

public class Producer {
    private var subject =  PassthroughSubject<Int, Never>()
    private var timer: Timer?
    private let dbSource: [Int]
    private var index: Int = 0

    public lazy var publisher: AnyPublisher<Int, Never> = {
        let instance = subject.eraseToAnyPublisher()
        return instance
    }()

    public init() {
        dbSource = Array((0...20))
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
            self.subject.send(self.dbSource[self.index])
            self.index += 1

            if self.index >= self.dbSource.count {
                timer.invalidate()
            }
        })

    }
}
