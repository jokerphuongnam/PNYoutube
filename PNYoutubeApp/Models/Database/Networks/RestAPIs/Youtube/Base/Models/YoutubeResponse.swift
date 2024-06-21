//
//  YoutubeResponse.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Alamofire

struct YoutubeResponse<Item: Codable & Hashable>: AFResponse {
    var request: DataRequest?
    let kind, etag: String
    let items: [Item]
    let nextPageToken: String
    let pageInfo: PageInfo
    
    static func == (lhs: YoutubeResponse<Item>, rhs: YoutubeResponse<Item>) -> Bool {
        lhs.items == rhs.items
    }
    
    var hashValue: Int {
        items.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        for item in items {
            hasher.combine(item)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case kind, etag
        case items
        case nextPageToken
        case pageInfo
    }
    
    // MARK: - PageInfo
    struct PageInfo: Codable, Sendable {
        let totalResults, resultsPerPage: Int
    }
}
