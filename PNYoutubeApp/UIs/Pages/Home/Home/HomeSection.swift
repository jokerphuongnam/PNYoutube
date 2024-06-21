//
//  HomeSection.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import Foundation

enum HomeSection: Hashable {
    case regular(item: FetchHomeVideosResonse)
    case shorts(items: [FetchHomeVideosResonse])
    
    var isRegular: Bool {
        switch self {
        case .regular:
            return true
        case .shorts:
            return false
        }
    }
}
