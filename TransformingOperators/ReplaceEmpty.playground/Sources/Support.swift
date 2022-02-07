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
