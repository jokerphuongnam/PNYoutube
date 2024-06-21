//
//  Thumbnails.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

struct Thumbnails: Codable & Hashable {
    let thumbnailsDefault, medium, high, standard: Thumbnail
    let maxres: Thumbnail?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
    
    func closestThumbnail(to screenWidth: CGFloat) -> Thumbnail {
        let thumbnailOptions = [
            thumbnailsDefault,
            medium,
            high,
            standard,
            maxres
        ].compactMap { thumbnail in
            thumbnail
        }
        
        let filteredThumbnails = thumbnailOptions.filter { CGFloat($0.width) >= screenWidth }
        
        if filteredThumbnails.isEmpty {
            return thumbnailOptions.min { $0.width < $1.width } ?? maxres ?? standard
        }
        
        let closest = filteredThumbnails.min {
            abs(CGFloat($0.width) - screenWidth) < abs(CGFloat($1.width) - screenWidth)
        }
        return closest ?? maxres ?? standard
    }
}
