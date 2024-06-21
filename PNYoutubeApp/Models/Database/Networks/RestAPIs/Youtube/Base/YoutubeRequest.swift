//
//  YoutubeRequest.swift
//  PNYoutube
//
//  Created by P. Nam on 19/06/2024.
//

import Foundation
import Alamofire

protocol YoutubeRequest: AFRequest {
    
}

extension YoutubeRequest {
    var baseURL: URL {
        URL(
            string: "https://" + (
                try! Configuration.value(
                    type: String.self,
                    for: Plists.XCConfig.baseUrl.key
                )
            )
        )!.appendingPathComponent(
            try! Configuration.value(
                type: String.self,
                for: Plists.XCConfig.youtubeV3.key
            )
        )
    }
    
    var encoding: URLEncoding {
        .queryString
    }
    
    var interceptor: RequestInterceptor? {
        PNAppDelegate.resolve(name: String(describing: YoutubeInterceptor.self))
    }
}
