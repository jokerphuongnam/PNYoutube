//
//  HomeViewModel.swift
//  PNYoutube
//
//  Created by P. Nam on 19/06/2024.
//

import Foundation
import Alamofire
import Kingfisher

final class HomeViewModel: ObservableObject {
    private let useCase: HomeUseCaseProtocol
    @Published var result: Resource<FetchHomeVideosRequest.Response> = .loading
    @Published var sections: Resource<[HomeSection]> = .loading
    
    private var nextPageToken: String? = nil
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadVideos() async {
        Task(priority: .high) { @MainActor [weak self] in
            guard let self else { return }
            self.result = .loading
        }
        do {
            let result = try await useCase.fetchHomeVideos(regionCode: "vn", nextPageToken: nextPageToken)
            let sections = createSections(items: result.items)
            Task(priority: .high) { @MainActor [weak self] in
                guard let self else { return }
                self.result = .success(data: result)
                self.sections = self.result.map { _ in
                    sections
                }
            }
        } catch {
            Task(priority: .high) { @MainActor [weak self] in
                guard let self else { return }
                self.result = .error(error: error)
            }
        }
    }
    
    private func createSections(items: [FetchHomeVideosResonse]) -> [HomeSection] {
        var videos: [HomeSection] = []
        var shortsBuffer: [FetchHomeVideosResonse] = []
        for item in items {
            let isShort = isYouTubeShort(item: item)
            if isShort {
                shortsBuffer.append(item)
            } else {
                if !shortsBuffer.isEmpty {
                    videos.append(.shorts(items: shortsBuffer))
                    shortsBuffer.removeAll()
                }
                videos.append(.regular(item: item))
            }
        }
        return videos
    }
    
    private func checkVerticalAspectRatio(thumbnailUrl: Thumbnail) -> Bool {
        thumbnailUrl.height > thumbnailUrl.width
    }
    
    private func isYouTubeShort(item: FetchHomeVideosResonse) -> Bool {
        let duration = item.contentDetails.duration.youtubeTimeToSeconds()
        let isShort = duration <= 60
        
        let isVertical = checkVerticalAspectRatio(thumbnailUrl: item.snippet.thumbnails.thumbnailsDefault)
        return isShort || item.snippet.title.contains("short")
    }
}
