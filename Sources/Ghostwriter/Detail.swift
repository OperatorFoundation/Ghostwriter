//
//  Detail.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

import Datable

public enum Types
{
    case string
    case int
    case uint
    case float
    case data
}

public enum Detail: Equatable
{
    case string(String)
    case int(Int)
    case uint(UInt)
    case float(Float)
    case data(Data)
}

extension Detail
{
    public var string: String
    {
        switch self
        {
            case .data(let value):
                return value.string
            case .float(let value):
                return String(value)
            case .int(let value):
                return value.string
            case .string(let value):
                return value
            case .uint(let value):
                return value.string
        }
    }
}
