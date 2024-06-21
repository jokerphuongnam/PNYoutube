//
//  String+Extension.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import Foundation

extension String {
    func youtubeTimeToSeconds() -> Int {
        var totalSeconds = 0
        
        let pattern = "PT((\\d+)H)?((\\d+)M)?((\\d+)S)?"
        let regex = try! NSRegularExpression(pattern: pattern)
        
        if let match = regex.firstMatch(in: self, range: NSRange(location: 0, length: utf16.count)) {
            let nsString = self as NSString
            
            if let hoursRange = Range(match.range(at: 2), in: self),
               let hours = Int(nsString.substring(with: NSRange(hoursRange, in: self))) {
                totalSeconds += hours * 3600
            }
            
            if let minutesRange = Range(match.range(at: 4), in: self),
               let minutes = Int(nsString.substring(with: NSRange(minutesRange, in: self))) {
                totalSeconds += minutes * 60
            }
            
            if let secondsRange = Range(match.range(at: 6), in: self),
               let seconds = Int(nsString.substring(with: NSRange(secondsRange, in: self))) {
                totalSeconds += seconds
            }
        }
        
        return totalSeconds
    }
}
