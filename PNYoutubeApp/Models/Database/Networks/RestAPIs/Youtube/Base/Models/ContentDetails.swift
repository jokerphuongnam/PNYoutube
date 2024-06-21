//
//  ContentDetails.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

struct ContentDetails: Codable & Hashable {
    let duration: String
    let dimension: Dimension
    let definition: Definition
    let caption: String
    let licensedContent: Bool
    let contentRating: ContentRating
    let projection: Projection
    let regionRestriction: RegionRestriction?
}
