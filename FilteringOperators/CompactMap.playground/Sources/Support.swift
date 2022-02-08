import Foundation
import Combine

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}
