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
    public func match(string input: String) -> MatchResult
    {
        switch self
        {
            case .generator(let generator):
                let typedText = generator()
                let desired = typedText.string
                guard input.count <= desired.count else
                {
                    return .SHORT
                }
            
                return typedText.match(string: input)

            case .regexp(let expression):
                guard let regex = try? NSRegularExpression(pattern: expression, options: []) else
                {
                    return .FAILURE
                }

                let range = NSRange(input.startIndex..<input.endIndex, in: input)

                let matches = regex.matches(in: input, options: [], range: range)

                guard let match = matches.first else
                {
                    return .SHORT
                }

                print("match.numberOfRanges - \(match.numberOfRanges)")

                let matchRange = match.range(at: 0)

                // Extract the substring matching the capture group
                print("data count: \(input.data.count), string count: \(input.count)")

                let startIndex = input.index(input.startIndex, offsetBy: matchRange.upperBound)
                let rest = String(input[startIndex..<input.endIndex])
            
                print("result length: \(rest.count)")

                return .SUCCESS(rest)

            case .special(let value):
                guard input.count > 0 else
                {
                    return .SHORT
                }
                
                guard let (first, rest) = try? input.text.splitAt(0) else
                {
                    return .SHORT
                }
                
                guard first == value.text else
                {
                    return .FAILURE
                }

                return .SUCCESS(rest.string)
            
            case .string(let desired):
                guard input.count <= desired.count else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? input.text.splitAt(input.count) else
                {
                    return .SHORT
                }
            
                if first == desired.text
                {
                    return .SUCCESS(rest.string)
                }
                else
                {
                    return .FAILURE
                }

            case .text(let desired):
                guard input.count <= desired.count() else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? input.text.splitAt(desired.count()) else
                {
                    return .SHORT
                }
            
                if first == desired
                {
                    return .SUCCESS(rest.string)
                }
                else
                {
                    return .FAILURE
                }
            
            case .newline(let newline):
                let desired = newline.string
                guard input.count <= desired.count else
                {
                    return .SHORT
                }
            
                guard let (first, rest) = try? input.text.splitAt(desired.count) else
                {
                    return .SHORT
                }
            
                if desired.text == first
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
