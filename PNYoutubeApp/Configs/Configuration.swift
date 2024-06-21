//
//  Configuration.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation

enum Configuration {
    public enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    public static func value<T>(type: T.Type, for key: String) throws -> T where T: LosslessStringConvertible {
        if let object = Bundle.main.object(forInfoDictionaryKey: key) {
            return try parseValue(object)
        }
        if let infoDictionary = Bundle.main.infoDictionary, let object = findValue(in: infoDictionary, forKey: key) {
            return try parseValue(object)
        }
        throw Error.missingKey
    }
    
    @inlinable public static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        try value(type: T.self, for: key)
    }
    
    private static func parseValue<T>(_ object: Any) throws -> T where T: LosslessStringConvertible {
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
    
    private static func findValue(in dictionary: [String: Any], forKey key: String) -> Any? {
        if let value = dictionary[key] {
            return value
        }
        
        for (_, value) in dictionary {
            if let nestedDict = value as? [String: Any] {
                if let result = findValue(in: nestedDict, forKey: key) {
                    return result
                }
            }
        }
        
        return nil
    }
}
