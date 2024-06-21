//
//  Number+Extension.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation

extension Int: Identifiable {
    public var id: Int { return self }
}

extension Double {
    var isSatisfyNumber: Bool {
        !isInfinite && !isNaN
    }
}
