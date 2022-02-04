import Foundation

public func execute(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}
