//
//  FetchHomeVideosRequest.swift
//  PNYoutube
//
//  Created by P. Nam on 19/06/2024.
//

import Foundation
import Alamofire

struct FetchHomeVideosRequest: YoutubeRequest {
    typealias Response = YoutubeResponse<FetchHomeVideosResonse>
    var path: String = "videos"
    var parameters: Parameters
    var method: HTTPMethod = .get
    
    init(regionCode: String, nextPageToken: String?) {
        self.parameters = [
            "part": "id,snippet,contentDetails,status",
            "chart": "mostPopular",
            "maxResults": 20,
            "regionCode": regionCode
        ]
        if let nextPageToken {
            parameters["pageToken"] = nextPageToken
        }
    }
}

struct FetchHomeVideosResonse: Codable & Hashable {
    let kind: Kind
    let etag, id: String
    let snippet: Snippet
    let contentDetails: ContentDetails
    let status: Status
}
