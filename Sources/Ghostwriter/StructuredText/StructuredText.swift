//
//  StructuredText.swift
//
//
//  Created by Dr. Brandon Wiley on 2/19/24.
//

import Foundation

import Text

public struct StructuredText
{
    public let texts: [TypedText]

    public init(texts: [TypedText])
    {
        self.texts = texts
    }

    public init(_ texts: TypedText...)
    {
        self.init(texts: texts)
    }
}

extension StructuredText
{
    public var string: String
    {
        return self.texts.map { $0.string }.joined()
    }
}

extension StructuredText
{
    public var data: Data
    {
        return self.string.data
    }
}

extension StructuredText
{
    public func match(string: String) -> MatchResult
    {
        var current = string
        for text in self.texts {
            let matchResult = text.match(string: current)
            switch matchResult {
            case .FAILURE:
                return .FAILURE
            case .SHORT:
                return .SHORT
            case .SUCCESS(let rest):
                current = rest
            }
        }
        
        return .SUCCESS(current)
    }
}

extension StructuredText: CustomStringConvertible
{
    public var description: String
    {
        self.texts.map { $0.description }.joined(separator: " ")
    }
}
