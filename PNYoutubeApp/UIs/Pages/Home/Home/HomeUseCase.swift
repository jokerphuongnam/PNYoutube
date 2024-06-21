//
//  HomeUseCase.swift
//  PNYoutube
//
//  Created by P. Nam on 20/06/2024.
//

import Foundation

protocol HomeUseCaseProtocol: Actor {
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response
}

final actor HomeUseCase: HomeUseCaseProtocol {
    private let youtubeRepository: YoutubeRepositoryProtocol
    
    init(youtubeRepository: YoutubeRepositoryProtocol) {
        self.youtubeRepository = youtubeRepository
    }
    
    func fetchHomeVideos(regionCode: String, nextPageToken: String?) async throws -> FetchHomeVideosRequest.Response {
        try await youtubeRepository.fetchHomeVideos(regionCode: regionCode, nextPageToken: nextPageToken)
    }
}
