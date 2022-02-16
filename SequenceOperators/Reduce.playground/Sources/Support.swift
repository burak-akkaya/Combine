import Foundation
import Combine

public func sample(of description: String, delay: TimeInterval = 0.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        print("\n----Sample of:", description, "----")
        action()
    }
}
