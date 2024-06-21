//
//  Resource.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

enum Resource<T: Hashable>: Hashable {
    case loading
    case success(data: T)
    case error(error: Error)
    
    var isLoading: Bool {
        self == .loading
    }
    
    var data: T? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .loading:
            hasher.combine(0)
        case .success(let data):
            hasher.combine(1)
            hasher.combine(data)
        case .error(let error):
            hasher.combine(2)
            hasher.combine(error.localizedDescription)
        }
    }
    
    func map<Result>(completion: (_ data: T) -> Result) -> Resource<Result> {
        switch self {
        case .loading:
            return .loading
        case .success(let data):
            return .success(data: completion(data))
        case .error(let error):
            return .error(error: error)
        }
    }
    
    static func == (lhs: Resource<T>, rhs: Resource<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.success(l), .success(r)):
            return l == r
        case let (.error(l), .error(r)):
            return l.localizedDescription == r.localizedDescription
        default:
            return false
        }
    }
}
