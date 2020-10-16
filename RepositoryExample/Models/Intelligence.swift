//
//  Intelligence.swift
//  RepositoryExample
//
//  Created by Mishko on 10/16/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation

enum Intelligence: Int {
    case unknown = 0
    case veryLow
    case low
    case intermediate
    case high
    case veryHigh
    
    var name: String {
        switch self {
        case .unknown:
            return "unknown"
        case .veryLow:
            return "very low"
        case .low:
            return "low"
        case .intermediate:
            return "intermediate"
        case .high:
            return "high"
        case .veryHigh:
            return "impressive"
        }
    }
}
