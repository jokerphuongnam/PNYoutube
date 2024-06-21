//
//  AFResponse.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation
import Alamofire

protocol AFResponse: Codable & Hashable {
    var request: DataRequest? { get set }
}
