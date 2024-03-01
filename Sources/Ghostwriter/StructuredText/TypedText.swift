//
//  TypedText.swift
//  Ghostwriter
//
//  Created by Dr. Brandon Wiley on 2/19/24.
//

import Foundation

import Text

public enum TypedText
{
    case generator(() -> TypedText)
    case regexp(String)
    case special(SpecialCharacter)
    case string(String)
    case text(Text)
    case newline(Newline)
}

extension TypedText
{
    public var string: String
    {
        switch self
        {
            case .generator(let generator):
                return generator().string

            case .regexp(let string):
                return string

            case .special(let special):
                return special.string

            case .string(let string):
                return string

            case .text(let text):
                return text.string

            case .newline(let newline):
                return newline.string
        }
    }
}

extension TypedText: CustomStringConvertible
{
    public var description: String
    {
        switch self
        {
            case .generator(let generator):
                return "() -> \(generator().string)"

            case .regexp(let string):
                return "/\(string)/"

            case .special(let special):
                return "[\(special.string)]"

            case .string(let string):
                return "\"\(string)\""

            case .text(let text):
                return "'\(text.string)'"

            case .newline(let newline):
                return newline.description
        }
    }
}

//extension TypedText
//{
//    public func match(string x: String) -> Bool
//    {
//        switch self
//        {
//            case .generator(let generator):
//                let text = generator().text
//                let prefix, rest = text
//                return generator().string.text. == string
//
//            case .regexp(let expression):
//                guard let regex = try? NSRegularExpression(pattern: expression, options: []) else
//                {
//                    return false
//                }
//
//                let range = NSRange(x.startIndex..<x.endIndex, in: x)
//
//                let matches = regex.matches(in: x, options: [], range: range)
//
//                guard let match = matches.first else
//                {
//                    return false
//                }
//
//                print("match.numberOfRanges - \(match.numberOfRanges)")
//                guard match.numberOfRanges > 1 else
//                {
//                    return false
//                }
//
//                let matchRange = match.range(at: 1)
//
//                // Extract the substring matching the capture group
//                print("data count: \(x.data.count), string count: \(x.count)")
//
//                let result = x.data[matchRange.lowerBound..<matchRange.upperBound].string
//
//                print("result length: \(result.count)")
//
//                return true
//
//            case .special(let special):
//                return special.string == string
//
//            case .string(let value):
//                return value == string
//
//            case .text(let text):
//                return text.string == string
//        }
//    }
//}
