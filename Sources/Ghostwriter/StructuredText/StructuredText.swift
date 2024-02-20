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
    let texts: [TypedText]

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
