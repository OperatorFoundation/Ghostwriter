//
//  ExtractionPattern.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

public class ExtractionPattern: Codable
{
    let expression: String
    let type: Types

    public init(_ expression: String, _ type: Types)
    {
        self.expression = expression
        self.type = type
    }

    public func extract(_ string: String) throws -> String
    {
        guard let result = self.extractor(string) else
        {
            throw ExtractionPatternError.extractionFailed
        }

        return result
    }

    public func convert(_ string: String) throws -> Detail
    {
        switch self.type
        {
            case .data:
                let value = Data(string: string)
                return .data(value)
            case .float:
                guard let value = Float(string) else
                {
                    throw ExtractionPatternError.conversionFailed(string, .float)
                }
                return .float(value)
            case .int:
                let value = Int(string: string)
                return .int(value)
            case .string:
                return .string(string)
            case .uint:
                let value = UInt(string: string)
                return .uint(value)
        }
    }

    func extractor(_ x: String) -> String?
    {
        guard let regex = try? NSRegularExpression(pattern: expression, options: []) else
        {
            return nil
        }

        let range = NSRange(x.startIndex..<x.endIndex, in: x)

        let matches = regex.matches(in: x, options: [], range: range)

        guard let match = matches.first else
        {
            return nil
        }
        
        print(match.numberOfRanges)
        let matchRange = match.range(at: 0)

        // Extract the substring matching the capture group
        print("data count: \(x.data.count), string count: \(x.count)")
        
        let result = x.data[matchRange.lowerBound..<matchRange.upperBound].string
        
        print("result length: \(result.count)")
        
        return result
//        if let substringRange = Range(matchRange, in: x)
//        {
//            let capture = String(x[substringRange])
//            return capture
//        }

        // return nil
    }
}

public enum ExtractionPatternError: Error
{
    case extractionFailed
    case conversionFailed(String, Types)
}
