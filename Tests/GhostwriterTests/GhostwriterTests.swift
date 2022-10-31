import XCTest
@testable import Ghostwriter

final class GhostwriterTests: XCTestCase {
    func testGenerateString() throws
    {
        let correct = "abz"
        let template = Template("a$1z")
        let details: [Detail] =
        [
            .string("b")
        ]

        let result = try Ghostwriter.generate(template, details)
        XCTAssertEqual(result, correct)
    }

    func testGenerateInt() throws
    {
        let correct = "a1z"
        let template = Template("a$1z")
        let details: [Detail] =
        [
            .int(1)
        ]

        let result = try Ghostwriter.generate(template, details)
        XCTAssertEqual(result, correct)
    }

    func testParseInt() throws
    {
        let correct = [Detail.int(1)]
        let template = Template("a$1z")
        let patterns: [ExtractionPattern] =
        [
            ExtractionPattern(#"([0-9]+)"#, .int)
        ]
        let input = "a1z"

        let result = try Ghostwriter.parse(template, patterns, input)
        XCTAssertEqual(result, correct)
    }

    func testParseString() throws
    {
        let correct = [Detail.string("b")]
        let template = Template("a$1z")
        let patterns: [ExtractionPattern] =
        [
            ExtractionPattern(#"([A-Za-z0-9])"#, .string)
        ]
        let input = "abz"

        let result = try Ghostwriter.parse(template, patterns, input)
        XCTAssertEqual(result, correct)
    }

    func testParseFloat() throws
    {
        let correct = [Detail.float(2.0)]
        let template = Template("a$1z")
        let patterns: [ExtractionPattern] =
        [
            ExtractionPattern(#"([0-9]+.[0-9]+)"#, .float)
        ]
        let input = "a2.0z"

        let result = try Ghostwriter.parse(template, patterns, input)
        XCTAssertEqual(result, correct)
    }
}
