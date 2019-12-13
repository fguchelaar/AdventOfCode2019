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

    public func extractInts() -> [Int] {
        return self.split(whereSeparator: { !"-1234567890".contains($0) }).compactMap { Int($0) }
    }
}
