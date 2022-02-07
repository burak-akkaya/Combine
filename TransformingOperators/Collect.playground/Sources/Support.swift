import Foundation

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class DataError: Error {
    public init() {}
}
