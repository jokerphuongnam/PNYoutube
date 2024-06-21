//
//  Int+Extension.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import Foundation

extension Int {
    func toTimeString() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%d:%02d", minutes, seconds)
        } else {
            return String(format: "%d", seconds)
        }
    }
}
