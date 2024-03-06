//
//  Newline.swift
//
//
//  Created by Dr. Brandon Wiley on 2/21/24.
//

import Foundation

public enum Newline: String
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
                return "<CR><LF>"

            case .posix:
                return "<LF>"

            case .qnx:
                return "<RS>"

            case .risc:
                return "<LF><CR>"

            case .windows:
                return "<CR><LF>"

            case .zx:
                return "<LF>"
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
