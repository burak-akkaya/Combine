import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class DataError: Error {
    public init() {}
}

public class DataProducer{
    public var subject: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")

    private var dbSource: [String]
    private var timer: Timer?
    private var index: Int = 0

    public init(data: [String]) {
        self.dbSource = data
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { timer in
            guard self.index < self.dbSource.count else {
                self.subject.send(completion: .finished)
                timer.invalidate()
                return
            }

            self.subject.send(self.dbSource[self.index])
            self.index += 1
        })
    }
}
