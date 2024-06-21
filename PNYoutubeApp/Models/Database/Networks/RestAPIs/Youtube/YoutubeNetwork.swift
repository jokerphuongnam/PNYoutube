//
//  YoutubeNetwork.swift
//  PNYoutube
//
//  Created by P. Nam on 18/06/2024.
//

import Foundation
import Alamofire

protocol YoutubeNetworkProtocol: Actor, AFNetwork {
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response
}

final actor YoutubeNetwork: YoutubeNetworkProtocol {
    private let session: Session
    private let decoder: JSONDecoder
    
    init(session: Session, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response {
        try await send(
            session: session,
            decoder: decoder,
            request: FetchHomeVideosRequest(
                regionCode: regionCode,
                nextPageToken: nextPageToken
            )
        )
    }
}
