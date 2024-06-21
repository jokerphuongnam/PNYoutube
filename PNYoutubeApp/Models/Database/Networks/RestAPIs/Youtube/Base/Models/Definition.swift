//
//  Definition.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

enum Definition: Codable & Hashable {
    case hd
    case `default`(value: String)
    
    var rawValue: String {
        switch self {
        case .hd:
            return "hd"
        case .default(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "hd":
            self = .hd
        default:
            self = .default(value: value)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
