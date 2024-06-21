//
//  YoutubeInterceptor.swift
//  PNYoutube
//
//  Created by P. Nam on 19/06/2024.
//

import Alamofire
import Foundation

final class YoutubeInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        urlRequest.addValue("PNYoutubeApp Dev/1.0 (com.pnam.youtube.app.dev; build:1; iOS 17.5.1) Alamofire/5.9.1 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
        
        if let url = urlRequest.url {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            var queryItems = urlComponents?.queryItems ?? []
            do {
                let key = try Configuration.value(type: String.self, for: Plists.XCConfig.apiYoutubeKey.key)
                queryItems.append(URLQueryItem(name: "key", value: key))
            } catch {
                print(error)
            }
            
            urlComponents?.queryItems = queryItems
            urlRequest.url = urlComponents?.url
        }
        
        completion(.success(urlRequest))
    }
}
