//
//  SpecialCharacter.swift
//  Ghostwriter
//
//  Created by Dr. Brandon Wiley on 2/19/24.
//

import Foundation

import Datable
import SwiftHexTools
import Text

public enum SpecialCharacter: UInt8
{
    case NUL = 0
    case SOH = 1
    case STX = 2
    case ETX = 3
    case EOT = 4
    case ENQ = 5
    case ACK = 6
    case BEL = 7
    case BS = 8
    case TAB = 9
    case LF = 10
    case VT = 11
    case FF = 12
    case CR = 13
    case SO = 14
    case SI = 15
    case DLE = 16
    case DC1 = 17
    case DC2 = 18
    case DC3 = 19
    case DC4 = 20
    case NAK = 21
    case SYN = 22
    case ETB = 23
    case CAN = 24
    case EM = 25
    case SUB = 26
    case ESC = 27
    case FS = 28
    case GS = 29
    case RS = 30
    case US = 31
    case Space = 32
    case DEL = 127
}

extension SpecialCharacter: CustomStringConvertible
{
    public var description: String
    {
        switch self
        {
            case .NUL:
                return "null"

            case .SOH:
                return "start of heading"

            case .STX:
                return "start of text"

            case .ETX:
                return "end of text"

            case .EOT:
                return "end of transmission"

            case .ENQ:
                return "enquiry"

            case .ACK:
                return "acknowledge"

            case .BEL:
                return "bell"

            case .BS:
                return "backspace"

            case .TAB:
                return "horizontal tab"

            case .LF:
                return "NL line feed / new line"

            case .VT:
                return "vertical tab"

            case .FF:
                return "NP form feed / new page"

            case .CR:
                return "carriage return"

            case .SO:
                return "shift out"

            case .SI:
                return "shift in"

            case .DLE:
                return "data link escape"

            case .DC1:
                return "device control one"

            case .DC2:
                return "device control two"

            case .DC3:
                return "device control three"

            case .DC4:
                return "device control four"

            case .NAK:
                return "negative acknowledgement"

            case .SYN:
                return "synchronous idle"

            case .ETB:
                return "end of transmission block"

            case .CAN:
                return "cancel"

            case .EM:
                return "end of medium"

            case .SUB:
                return "substitute"

            case .ESC:
                return "escape"

            case .FS:
                return "file separator"

            case .GS:
                return "group separator"

            case .RS:
                return "record separator"

            case .US:
                return "unit separator"

            case .Space:
                return "space"

            case .DEL:
                return "delete"
        }
    }
}

extension SpecialCharacter
{
    public var string: String
    {
        let data = Data(array: [self.rawValue])
        return data.string
    }

    public init?(string: String)
    {
        let data = string.data

        guard data.count == 0 else
        {
            return nil
        }

        let char = data[0]

        self.init(rawValue: char)
    }
}

extension SpecialCharacter
{
    public var data: Data
    {
        return Data(array: [self.rawValue])
    }

    public init?(data: Data)
    {
        guard data.count == 0 else
        {
            return nil
        }

        let char = data[0]

        self.init(rawValue: char)
    }
}

extension SpecialCharacter
{
    public var text: Text
    {
        return self.string.text
    }

    public init?(text: Text)
    {
        self.init(string: text.string)
    }
}

extension SpecialCharacter
{
    public var hex: String
    {
        return self.data.hex
    }

    public init?(hex: String)
    {
        guard let data = Data(hex: hex) else
        {
            return nil
        }

        self.init(data: data)
    }
}

extension SpecialCharacter
{
    public var base64: String
    {
        return self.data.base64EncodedString()
    }

    public init?(base64: String)
    {
        guard let data = Data(base64Encoded: base64) else
        {
            return nil
        }

        self.init(data: data)
    }
}
