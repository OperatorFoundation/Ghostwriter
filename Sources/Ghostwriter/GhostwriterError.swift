//
//  GhostwriterError.swift
//  
//
//  Created by Dr. Brandon Wiley on 5/9/22.
//

import Foundation

public enum GhostwriterError: Error
{
    case tooManyDetails(Int)
    case tooManyPatterns(Int)
}
