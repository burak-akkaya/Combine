import Combine
import Foundation

public class SampleObject {
    public var value: String = "" {
        didSet{
            print("Sample Object Value is: ", value)
        }
    }

    public init() {
        
    }
}
