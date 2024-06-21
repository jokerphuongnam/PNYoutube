//
//  Snippet.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

struct Snippet: Codable & Hashable {
    let publishedAt: Date
    let channelID, title, description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]?
    let categoryID: String
    let liveBroadcastContent: LiveBroadcastContent
    let localized: Localized
    let defaultAudioLanguage, defaultLanguage: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title, description, thumbnails, channelTitle, tags
        case categoryID = "categoryId"
        case liveBroadcastContent, localized, defaultAudioLanguage, defaultLanguage
    }
}
