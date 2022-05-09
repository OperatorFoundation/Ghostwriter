//
//  Template.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

public struct Template
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

        // Find the substitution in the template
        guard let index = self.string.index(of: oldText) else
        {
            throw TemplateError.noSubstitution(oldText)
        }

        let templatePreludeIndex = self.string.index(index, offsetBy: oldText.count)
        let sourcePreludeIndex = source.index(index, offsetBy: 0)

        let prelude = String(self.string[..<index])

        guard source.starts(with: prelude) else
        {
            throw TemplateError.sourceDoesNotMatchTemplate
        }

        let templateRest = String(self.string[templatePreludeIndex...])
        let sourceRest = String(source[sourcePreludeIndex...])

        let result = try pattern.extract(sourceRest)
        let detail = try pattern.convert(result)

        guard var matchIndex = sourceRest.index(of: result) else
        {
            throw TemplateError.sourceDoesNotMatchTemplate
        }
        matchIndex = sourceRest.index(matchIndex, offsetBy: result.count)

        let sourceFinal = String(sourceRest[matchIndex...])

        return (Template(templateRest), sourceFinal, detail)
    }
}

public enum TemplateError: Error
{
    case sourceDoesNotMatchTemplate
    case noSubstitution(String)
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
