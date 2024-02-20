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
        }
    }
}
