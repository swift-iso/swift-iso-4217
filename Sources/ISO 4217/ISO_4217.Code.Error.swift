extension ISO_4217.Code {
    public enum Error: Swift::Error, Sendable, Equatable {
        case invalidLength(String)
        case invalidCharacters(String)
    }
}
