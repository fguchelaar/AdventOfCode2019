import Foundation

extension String {

    public func array<T>(
        separatedBy characterSet: CharacterSet, using function: (String) -> T?
    ) -> [T] {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: characterSet)
            .compactMap(function)
    }

    public var intArray: [Int] {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }
}
