extension ISO_4217.Code {
    /// A currency as list one publishes it.
    public struct Entry: Sendable, Equatable, Hashable {
        /// The three-digit numeric code, leading zeros kept.
        public let numeric: String
        /// Digits after the decimal mark; nil where the list says "N.A.", as for gold.
        public let minorUnits: Int?
        public let name: String

        package init(numeric: String, minorUnits: Int?, name: String) {
            self.numeric = numeric
            self.minorUnits = minorUnits
            self.name = name
        }
    }
}
