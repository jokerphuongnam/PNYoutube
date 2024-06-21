//
//  AFNetworkError.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation

struct AFResponseError: Decodable {
    let statusCode: Int?
    let status: Bool?
    let message: String?

    init(_ status: Bool, statusCode: Int? = nil) {
        self.status = status
        self.statusCode = statusCode
        message = nil
    }

    init(_ message: String, statusCode: Int? = nil) {
        self.message = message
        self.statusCode = statusCode
        status = nil
    }
    
    init(status: Bool, message: String, statusCode: Int? = nil) {
        self.status = status
        self.message = message
        self.statusCode = statusCode
    }
}

extension AFResponseError: Equatable {
    static func == (lhs: AFResponseError, rhs: AFResponseError) -> Bool {
        return lhs.status == rhs.status && lhs.message == rhs.message
    }
}

enum AFNetworkError: Error {
    case connectionFailed(Error)
    case serverError
    case maintenance
    case otherError(AFResponseError)
    case unknownError(AFResponseError)
    case dataNotExist
    case statusCodeNotExist
    case timeout
    case noConnection
    case expired

    func responseDecode() -> Decodable? {
        switch self {
        case .connectionFailed(_):
            return nil
        case .serverError:
            return nil
        case .maintenance:
            return nil
        case .otherError(let data):
            return data
        case .unknownError(let data):
            return data
        case .dataNotExist:
            return nil
        case .statusCodeNotExist:
            return nil
        case .timeout:
            return nil
        case .noConnection:
            return nil
        case .expired:
            return nil
        }
    }
}

extension AFNetworkError: Equatable {
    static func == (lhs: AFNetworkError, rhs: AFNetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.connectionFailed(_), .connectionFailed(_)):
            return true
        case (.serverError, .serverError):
            return true
        case (.maintenance, .maintenance):
            return true
        case (.otherError(let a), .otherError(let b)):
            return a == b
        case (.unknownError(let a), .unknownError(let b)):
            return a == b
        case (.dataNotExist, .dataNotExist):
            return true
        case (.statusCodeNotExist, .statusCodeNotExist):
            return true
        default:
            return false
        }
    }
}
