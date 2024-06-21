//
//  AFRequest.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation
import Alamofire

protocol AFRequest where Self.Response: AFResponse {
    associatedtype Response

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var url: URL { get }
    var parameters: Parameters { get }
    var httpHeaderFields: HTTPHeaders { get }
    var encoding: URLEncoding { get }
    var interceptor: RequestInterceptor? { get }
}

extension AFRequest {
    var encoding: URLEncoding {
        .default
    }
    
    var httpHeaderFields: HTTPHeaders {
        [:]
    }
    
    var parameters: Parameters {
        [:]
    }
    
    var interceptor: RequestInterceptor? {
        nil
    }
    
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
    
    var method: HTTPMethod {
        .get
    }
}
