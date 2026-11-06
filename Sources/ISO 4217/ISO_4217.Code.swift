extension ISO_4217 {
    /// A three-letter currency code, stored uppercase. Withdrawn codes stay valid, so old records stay readable.
    public struct Code: Sendable, Equatable, Hashable {
        public let value: String

        public init(_ value: some StringProtocol) throws(Error) {
            let utf8 = Array(value.utf8)
            guard utf8.count == 3 else { throw Error.invalidLength(String(value)) }
            var uppercased: [UInt8] = []
            uppercased.reserveCapacity(3)
            for byte in utf8 {
                switch byte {
                case UInt8(ascii: "A")...UInt8(ascii: "Z"): uppercased.append(byte)
                case UInt8(ascii: "a")...UInt8(ascii: "z"): uppercased.append(byte - 32)
                default: throw Error.invalidCharacters(String(value))
                }
            }
            self.value = String(decoding: uppercased, as: UTF8.self)
        }

        internal init(unchecked value: String) {
            self.value = value
        }
    }
}

extension ISO_4217.Code {
    /// What list one publishes for this code; nil for a code it doesn't hold, such as a withdrawn one.
    public var entry: Entry? { Self.table[self] }
}

extension ISO_4217.Code: CustomStringConvertible {
    public var description: String { value }
}

extension ISO_4217.Code: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(try container.decode(String.self))
    }
}
