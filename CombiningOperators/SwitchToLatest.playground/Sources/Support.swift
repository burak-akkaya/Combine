import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}


public class DataProducer {
    public var publishers = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()


    public init() {

    }

    public func sendData(){
        let subject1 = PassthroughSubject<Int, Never>()
        let subject2 = PassthroughSubject<Int, Never>()
        let subject3 = PassthroughSubject<Int, Never>()

        publishers.send(subject1)
        subject1.send(1)
        subject1.send(2)


        publishers.send(subject2)
        subject2.send(4)
        subject2.send(5)
        subject1.send(3)
        
        publishers.send(subject3)
        subject2.send(6)
        subject3.send(7)
        subject3.send(8)
        subject3.send(9)

        subject3.send(completion: .finished)
        publishers.send(completion: .finished)


    }
}
