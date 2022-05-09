//
//  Ghostwriter.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

public class Ghostwriter
{
    static public func generate(_ template: Template, _ details: [Detail]) throws -> String
    {
        var result = template

        guard details.count < 10 else
        {
            throw GhostwriterError.tooManyDetails(details.count)
        }

        for (index, detail) in details.enumerated()
        {
            result = try result.apply(index + 1, detail)
        }

        return result.string
    }

    static public func parse(_ template: Template, _ patterns: [ExtractionPattern], _ string: String) throws -> [Detail]
    {
        var working = template
        var source = string

        var details: [Detail] = []

        guard patterns.count < 10 else
        {
            throw GhostwriterError.tooManyPatterns(patterns.count)
        }

        for (index, pattern) in patterns.enumerated()
        {
            let (newTemplate, newSource, detail) = try working.extract(index + 1, pattern, source)
            working = newTemplate
            source = newSource
            details.append(detail)
        }

        guard working.string == source else
        {
            throw TemplateError.sourceDoesNotMatchTemplate
        }

        return details
    }
}
