//
//  Dimension.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

enum Dimension: Codable & Hashable {
    case the2D
    case `default`(value: String)
    
    var rawValue: String {
        switch self {
        case .the2D:
            return "2d"
        case .default(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "2d":
            self = .the2D
        default:
            self = .default(value: value)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
