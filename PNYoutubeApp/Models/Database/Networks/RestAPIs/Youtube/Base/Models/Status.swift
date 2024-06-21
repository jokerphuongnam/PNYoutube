//
//  Status.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

struct Status: Codable, Hashable {
    let uploadStatus: UploadStatus
    let privacyStatus: PrivacyStatus
    let license: License
    let embeddable, publicStatsViewable, madeForKids: Bool
}
