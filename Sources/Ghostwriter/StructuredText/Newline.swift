//
//  Newline.swift
//
//
//  Created by Dr. Brandon Wiley on 2/21/24.
//

import Foundation

public enum Newline
{
    case crlf
    case posix
    case qnx
    case risc
    case windows
    case zx
}

extension Newline: CustomStringConvertible
{
    public var description: String
    {
        switch self
        {
            case .crlf:
                return SpecialCharacter.CR.description + SpecialCharacter.LF.description

            case .posix:
                return SpecialCharacter.LF.description

            case .qnx:
                return SpecialCharacter.RS.description

            case .risc:
                return SpecialCharacter.LF.description + SpecialCharacter.CR.description

            case .windows:
                return SpecialCharacter.CR.description + SpecialCharacter.LF.description

            case .zx:
                return SpecialCharacter.LF.description
        }
    }
}

extension Newline
{
    public var string: String
    {
        switch self
        {
            case .crlf:
                return SpecialCharacter.CR.string + SpecialCharacter.LF.string

            case .posix:
                return SpecialCharacter.LF.string

            case .qnx:
                return SpecialCharacter.RS.string

            case .risc:
                return SpecialCharacter.LF.string + SpecialCharacter.CR.string

            case .windows:
                return SpecialCharacter.CR.string + SpecialCharacter.LF.string

            case .zx:
                return SpecialCharacter.LF.string
        }
    }
}
