import Foundation
@testable import ISO_4217
import Testing

@Suite
struct ISO_4217_Code_Tests {
    @Test
    func `Stores uppercase`() throws {
        #expect(try ISO_4217.Code("eur").value == "EUR")
        #expect(try ISO_4217.Code("EuR") == .eur)
    }

    @Test
    func `Refuses a wrong length`() {
        #expect(throws: ISO_4217.Code.Error.invalidLength("EU")) { try ISO_4217.Code("EU") }
        #expect(throws: ISO_4217.Code.Error.invalidLength("EURO")) { try ISO_4217.Code("EURO") }
        #expect(throws: ISO_4217.Code.Error.invalidLength("")) { try ISO_4217.Code("") }
    }

    @Test
    func `Refuses anything but ASCII letters`() {
        #expect(throws: ISO_4217.Code.Error.invalidCharacters("E1R")) { try ISO_4217.Code("E1R") }
        #expect(throws: ISO_4217.Code.Error.invalidLength("€UR")) { try ISO_4217.Code("€UR") }
        #expect(throws: ISO_4217.Code.Error.invalidCharacters("E R")) { try ISO_4217.Code("E R") }
    }

    @Test
    func `A withdrawn code is a code with no entry`() throws {
        let guilder = try ISO_4217.Code("NLG")
        #expect(guilder.value == "NLG")
        #expect(guilder.entry == nil)
    }

    @Test
    func `Entries hold what list one publishes`() {
        #expect(ISO_4217.Code.eur.entry == .init(numeric: "978", minorUnits: 2, name: "Euro"))
        #expect(ISO_4217.Code.jpy.entry?.minorUnits == 0)
        #expect(ISO_4217.Code.kwd.entry?.minorUnits == 3)
        #expect(ISO_4217.Code.xau.entry?.minorUnits == nil)
        #expect(ISO_4217.Code.all.entry?.numeric == "008")
    }

    @Test
    func `Encodes as its stored string, and decoding validates`() throws {
        let data = try JSONEncoder().encode(ISO_4217.Code.usd)
        #expect(String(decoding: data, as: UTF8.self) == "\"USD\"")
        #expect(try JSONDecoder().decode(ISO_4217.Code.self, from: Data("\"usd\"".utf8)) == .usd)
        #expect(throws: (any Swift.Error).self) { try JSONDecoder().decode(ISO_4217.Code.self, from: Data("\"EURO\"".utf8)) }
    }
}
