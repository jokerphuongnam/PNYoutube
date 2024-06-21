//
//  YoutubeRepository.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

protocol YoutubeRepositoryProtocol: Actor {
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response
}

final actor YoutubeRepository: YoutubeRepositoryProtocol {
    private let network: YoutubeNetworkProtocol
    
    init(network: YoutubeNetworkProtocol) {
        self.network = network
    }
    
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response {
        try await network.fetchHomeVideos(regionCode: regionCode, nextPageToken: nextPageToken)
    }
}
