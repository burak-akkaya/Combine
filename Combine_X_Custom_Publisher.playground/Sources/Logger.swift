import Foundation

public func execute(of description: String, action: () -> Void) {
    print("Action of:", description, "----\n")
    action()
}


