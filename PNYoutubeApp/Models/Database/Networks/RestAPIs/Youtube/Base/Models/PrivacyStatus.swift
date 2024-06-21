//
//  PrivacyStatus.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

enum PrivacyStatus: Codable, Hashable {
    case privacyStatusPublic
    case `default`(value: String)
    
    var rawValue: String {
        switch self {
        case .privacyStatusPublic:
            return "public"
        case .default(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "public":
            self = .privacyStatusPublic
        default:
            self = .default(value: value)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
