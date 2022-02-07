import Foundation

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class DataError: Error {
    public init() {}
}

public extension String {
    func isGood() throws -> String {
        if self.lowercased() == "swiftui"{
            throw DataError()
        }
        return self
    }
}
