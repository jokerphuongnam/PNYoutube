//
//  Date+Extension.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import Foundation

extension Date {
    func dateAgoString(limitAgo: LimitAgo? = nil) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: currentDate, to: self)
        
        if let month = components.month, month <= -1 {
            return month == -1 ? Strings.PNYoutube.Common._1MonthAgoTitle : Strings.PNYoutube.Common.monthsAgoTitle(-month)
        }
        if case .days(let days, let msg) = limitAgo {
            if let day = components.day, day <= -days {
                return day == -1 ? Strings.PNYoutube.Common._1DayAgoTitle : Strings.PNYoutube.Common.dayAgosTitle(-day)
            } else {
                return msg
            }
        }
        if let day = components.day, day <= -1 {
            return day == -1 ? Strings.PNYoutube.Common._1DayAgoTitle : Strings.PNYoutube.Common.dayAgosTitle(-day)
        }
        if let hour = components.hour, hour <= -1 {
            return hour == 1 ? Strings.PNYoutube.Common._1HourAgoTitle : Strings.PNYoutube.Common.hoursAgoTitle(-hour)
        }
        if limitAgo == .limitToOneHour {
            return Strings.PNYoutube.Common._1HourAgoTitle
        }
        if let mins = components.minute, mins <= -1 {
            return mins == 1 ? Strings.PNYoutube.Common._1MinAgoTitle : Strings.PNYoutube.Common.minsAgoTitle(-mins)
        }
        return nil
    }
    
    enum LimitAgo: Equatable {
        case days(days: Int, msg: String)
        case limitToOneHour
        
        public static func==(lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.days(let lhs, _),.days(let rhs, _)):
                return lhs == rhs
            case (.limitToOneHour, .limitToOneHour):
                return true
            default:
                return false
            }
        }
    }
}
