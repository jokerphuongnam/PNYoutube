//
//  ErrorModel.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation

struct ErrorModel: Error {
    var message: String = ""
    var code: Int = 0
}

enum AppError: Error {
    case ownerNil
    case canNotConvertObject
    case noPrizes
}

enum NetworkErrorCase: Error {
    case cannotConnectionInternet
    case cannotConnectToHost
    case timeOut
}

enum LocalErrorCase: Error {
    case notFound
}
