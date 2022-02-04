import UIKit
import Combine

execute(of: "Future") {
    func futureIncrement(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
        return Future<Int, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                promise(.success(integer + 1))
            }
        }
    }
}

final public class Future<Output, Failure> : Publisher where Failure: Error {
    public typealias Promise = (Result<Output, Failure>) -> Void



    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {

    }
}
