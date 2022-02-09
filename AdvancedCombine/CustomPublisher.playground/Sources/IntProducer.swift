import Foundation
import Combine

public struct IntPublisher: Publisher {
    public typealias Output = Int

    public typealias Failure = DataError
    public init() {}
    public func receive<S>(subscriber: S) where S : Subscriber, DataError == S.Failure, Int == S.Input {
        let subscription = IntSubscription<S>(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

public class IntSubscription<S: Subscriber>: Subscription where S.Input == Int{
    var subscriber: S?
    var timer: Timer?
    var count: Int

    public init(subscriber: S){
        count = 0
        self.subscriber = subscriber
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(send), userInfo: nil, repeats: true)
    }

    public func request(_ demand: Subscribers.Demand) {}

    public func cancel() {
        subscriber = nil
    }

    @objc public func send(){
        _ = subscriber?.receive(count)
        count+=1
        if count == 5 {
            subscriber?.receive(completion: .finished)
            timer?.invalidate()
        }
    }

}

public class DataError: Error{

}
