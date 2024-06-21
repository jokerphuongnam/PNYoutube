//
//  LiveBroadcastContent.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

enum LiveBroadcastContent: Codable & Hashable {
    case none
    case `default`(value: String)
    
    var rawValue: String {
        switch self {
        case .none:
            return "none"
        case .default(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "none":
            self = .none
        default:
            self = .default(value: value)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
