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

public enum SpecialCharacter: String
{
    case NUL
    case SOH
    case STX
    case ETX
    case EOT
    case ENQ
    case ACK
    case BEL
    case BS
    case TAB
    case LF
    case VT
    case FF
    case CR
    case SO
    case SI
    case DLE
    case DC1
    case DC2
    case DC3
    case DC4
    case NAK
    case SYN
    case ETB
    case CAN
    case EM
    case SUB
    case ESC
    case FS
    case GS
    case RS
    case US
    case Space
    case DEL
}

extension SpecialCharacter
{
    public var uint8: UInt8
    {
        switch self
        {
            case .NUL:
                return 0
            case .SOH:
                return 1

            case .STX:
                return 2

            case .ETX:
                return 3

            case .EOT:
                return 4

            case .ENQ:
                return 5

            case .ACK:
                return 6

            case .BEL:
                return 7

            case .BS:
                return 8

            case .TAB:
                return 9

            case .LF:
                return 10

            case .VT:
                return 11

            case .FF:
                return 12

            case .CR:
                return 13

            case .SO:
                return 14

            case .SI:
                return 15

            case .DLE:
                return 16

            case .DC1:
                return 17

            case .DC2:
                return 18

            case .DC3:
                return 19

            case .DC4:
                return 20

            case .NAK:
                return 21

            case .SYN:
                return 22

            case .ETB:
                return 23

            case .CAN:
                return 24

            case .EM:
                return 25

            case .SUB:
                return 26

            case .ESC:
                return 27

            case .FS:
                return 28

            case .GS:
                return 29

            case .RS:
                return 30

            case .US:
                return 31

            case .Space:
                return 32

            case .DEL:
                return 127
        }
    }

    public init?(uint8: UInt8)
    {
        switch uint8
        {
            case 0:
                self = .NUL

            case 1:
                self = .SOH

            case 2:
                self = .STX

            case 3:
                self = .ETX

            case 4:
                self = .EOT

            case 5:
                self = .ENQ

            case 6:
                self = .ACK

            case 7:
                self = .BEL

            case 8:
                self = .BS

            case 9:
                self = .TAB

            case 10:
                self = .LF

            case 11:
                self = .VT

            case 12:
                self = .FF

            case 13:
                self = .CR

            case 14:
                self = .SO

            case 15:
                self = .SI

            case 16:
                self = .DLE

            case 17:
                self = .DC1

            case 18:
                self = .DC2

            case 19:
                self = .DC3

            case 20:
                self = .DC4

            case 21:
                self = .NAK

            case 22:
                self = .SYN

            case 23:
                self = .ETB

            case 24:
                self = .CAN

            case 25:
                self = .EM

            case 26:
                self = .SUB

            case 27:
                self = .ESC

            case 28:
                self = .FS

            case 29:
                self = .GS

            case 30:
                self = .RS

            case 31:
                self = .US

            case 32:
                self = .Space

            case 127:
                self = .DEL

            default:
                return nil
        }
    }
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
        let data = Data(array: [self.uint8])
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

        self.init(uint8: char)
    }
}

extension SpecialCharacter
{
    public var data: Data
    {
        return Data(array: [self.uint8])
    }

    public init?(data: Data)
    {
        guard data.count == 0 else
        {
            return nil
        }

        let char = data[0]

        self.init(uint8: char)
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
