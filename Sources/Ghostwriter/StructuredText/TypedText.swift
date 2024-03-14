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

extension TypedText
{
    public func match(string x: String) -> MatchResult
    {
        switch self
        {
            case .generator(let generator):
                let typedText = generator()
                let string = typedText.string
                guard string.count <= x.count else
                {
                    return .SHORT
                }
            
                return typedText.match(string: x)

            case .regexp(let expression):
                guard let regex = try? NSRegularExpression(pattern: expression, options: []) else
                {
                    return .FAILURE
                }

                let range = NSRange(x.startIndex..<x.endIndex, in: x)

                let matches = regex.matches(in: x, options: [], range: range)

                guard let match = matches.first else
                {
                    return .SHORT
                }

                print("match.numberOfRanges - \(match.numberOfRanges)")

                let matchRange = match.range(at: 0)

                // Extract the substring matching the capture group
                print("data count: \(x.data.count), string count: \(x.count)")

                let startIndex = x.index(x.startIndex, offsetBy: matchRange.upperBound)
                let rest = String(x[startIndex..<x.endIndex])
            
                print("result length: \(rest.count)")

                return .SUCCESS(rest)

            case .special(let value):
                guard x.count > 0 else
                {
                    return .SHORT
                }
                
                guard let (first, rest) = try? x.text.splitAt(0) else
                {
                    return .SHORT
                }
                
                guard first == value.text else
                {
                    return .FAILURE
                }

                return .SUCCESS(rest.string)
            
            case .string(let value):
                guard value.count <= x.count else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? x.text.splitAt(x.count) else
                {
                    return .SHORT
                }
            
                if value.text == first
                {
                    return .SUCCESS(rest.string)
                }
                else
                {
                    return .FAILURE
                }

            case .text(let value):
                guard value.count() <= x.count else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? x.text.splitAt(value.count()) else
                {
                    return .SHORT
                }
            
                if value == first
                {
                    return .SUCCESS(rest.string)
                }
                else
                {
                    return .FAILURE
                }
            
            case .newline(let newline):
                let value = newline.string
                guard value.count <= x.count else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? x.text.splitAt(value.count) else
                {
                    return .SHORT
                }
            
                if value.text == first
                {
                    return .SUCCESS(rest.string)
                }
                else
                {
                    return .FAILURE
                }
        }
    }
}
