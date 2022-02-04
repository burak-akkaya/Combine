import Foundation

public func sample(of description: String, action: () -> Void) {
    print("\n----Sample of:", description, "----")
    action()
}

public class DataError: Error {
    public init() {}
}

public extension String {
    func replaceVowels() -> String {
        let vowels = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        var value = self
        vowels.forEach({
            value = value.replacingOccurrences(of: $0, with: "*")
        })

        return value
    }
}


