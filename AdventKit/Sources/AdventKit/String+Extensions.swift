import Foundation

extension String {
    public var intArray: [Int] {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }
}
