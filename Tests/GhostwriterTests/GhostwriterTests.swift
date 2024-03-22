import XCTest
import Text
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
    
    func testTypedTextString() throws
    {
        let typedTextString = TypedText.string("Test")
        let matchResult = typedTextString.match(string: "Test")
        switch matchResult {
        case .SUCCESS(let rest):
            XCTAssertEqual(rest, "")
        default:
            XCTFail()
        }
        
        let shortMatchResult = typedTextString.match(string: "Tes")
        switch shortMatchResult {
        case .SHORT:
            return
        default:
            XCTFail()
        }
        
        let failureMatchResult = typedTextString.match(string: "Fail")
        switch failureMatchResult {
        case .FAILURE:
            return
        default:
            XCTFail()
        }
    }
    
    func testTypedTextText() throws
    {
        let text = Text(stringLiteral: "Text")
        let typedText = TypedText.text(text)
        let matchResult = typedText.match(string: "Test")
        switch matchResult {
        case .SUCCESS(let rest):
            XCTAssertEqual(rest, "")
        default:
            XCTFail()
        }
        
        let shortMatchResult = typedText.match(string: "Tes")
        switch shortMatchResult {
        case .SHORT:
            return
        default:
            XCTFail()
        }
        
        let failureMatchResult = typedText.match(string: "Fail")
        switch failureMatchResult {
        case .FAILURE:
            return
        default:
            XCTFail()
        }
    }
    
    func testTypedTextNewline() throws
    {
        let text = Newline.posix
        let typedText = TypedText.newline(text)
        let matchResult = typedText.match(string: "<LF>")
        switch matchResult {
        case .SUCCESS(let rest):
            XCTAssertEqual(rest, "")
        default:
            XCTFail()
        }
        
        let failureMatchResult = typedText.match(string: "Fail")
        switch failureMatchResult {
        case .FAILURE:
            return
        default:
            XCTFail()
        }
    }
    
    func testTypedTextGenerator() throws
    {
//        let text
//        let typedText = TypedText.generator(<#T##() -> TypedText#>)
//        let matchResult = typedText.match(string: "<LF>")
//        switch matchResult {
//        case .SUCCESS(let rest):
//            XCTAssertEqual(rest, "")
//        default:
//            XCTFail()
//        }
//        
//        let failureMatchResult = typedText.match(string: "Fail")
//        switch failureMatchResult {
//        case .FAILURE:
//            return
//        default:
//            XCTFail()
//        }
    }
    
    func testTypedTextSpecial() throws
    {
        let text = SpecialCharacter.ACK
        let typedText = TypedText.special(text)
        let matchResult = typedText.match(string: "acknowledge")
        switch matchResult {
        case .SUCCESS(let rest):
            XCTAssertEqual(rest, "")
        default:
            XCTFail()
        }
        
        let failureMatchResult = typedText.match(string: "Fail")
        switch failureMatchResult {
        case .FAILURE:
            return
        default:
            XCTFail()
        }
    }
    
    func testTypedTextRegexp() throws
    {
        let typedTextString = TypedText.regexp("[A-Z][a-z]+t")
        let matchResult = typedTextString.match(string: "Test")
        switch matchResult {
        case .SUCCESS(let rest):
            XCTAssertEqual(rest, "")
        default:
            XCTFail()
        }
        
        let shortMatchResult = typedTextString.match(string: "Tes")
        switch shortMatchResult {
        case .SHORT:
            return
        default:
            XCTFail()
        }
        
        let failureMatchResult = typedTextString.match(string: "Fail")
        switch failureMatchResult {
        case .SHORT:
            return
        default:
            XCTFail()
        }
    }
}
