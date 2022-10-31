//
//  Template.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

public struct Template: Codable
{
    let string: String

    public init(_ string: String)
    {
        self.string = string
    }

    public func apply(_ index: Int, _ detail: Detail) throws -> Template
    {
        let oldText = "$\(index)"
        let newText = detail.string

        guard self.string.contains(oldText) else
        {
            throw TemplateError.noSubstitution(oldText)
        }

        let result = self.string.replacingOccurrences(of: oldText, with: newText)

        return Template(result)
    }

    public func extract(_ index: Int, _ pattern: ExtractionPattern, _ source: String) throws -> (Template, String, Detail)
    {
        let oldText = "$\(index)"
        
        guard !source.isEmpty else
        {
            throw TemplateError.sourceIsEmpty
        }

        // Find the substitution in the template
        guard let oldTextStringIndex = self.string.index(of: oldText) else
        {
            throw TemplateError.noSubstitution(oldText)
        }
        
        // All of the text that precedes the variable we are looking for
        let prelude = String(self.string[..<oldTextStringIndex])
        
        guard source.count >= prelude.count else
        {
            throw TemplateError.sourceTooSmall(source)
        }
        
        // Make sure that the text we got matches the beginning of our template
        guard source.starts(with: prelude) else
        {
            throw TemplateError.sourceDoesNotMatchTemplate
        }
        
        // Extract the variable we are looking for
        let sourceAfterwordStringIndex = source.index(oldTextStringIndex, offsetBy: 0)
        let sourceRest = String(source[sourceAfterwordStringIndex...])

        let result = try pattern.extract(sourceRest)
        let detail = try pattern.convert(result)

        guard var matchIndex = sourceRest.index(of: result) else
        {
            throw TemplateError.sourceDoesNotMatchTemplate
        }
        
        matchIndex = sourceRest.index(matchIndex, offsetBy: result.count)

        // The variable we are looking for
        let sourceFinal = String(sourceRest[matchIndex...])
        
        // Return the part of the template which comes after the variable we extracted
        let templateAfterwordStringIndex = self.string.index(oldTextStringIndex, offsetBy: oldText.count)
        let templateRest = String(self.string[templateAfterwordStringIndex...])
        
        return (Template(templateRest), sourceFinal, detail)
    }
}

public enum TemplateError: Error
{
    case sourceDoesNotMatchTemplate
    case noSubstitution(String)
    case sourceTooSmall(String)
    case sourceIsEmpty
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
            .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
