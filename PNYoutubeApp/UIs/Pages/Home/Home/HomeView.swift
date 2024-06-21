//
//  HomeView.swift
//  PNYoutube
//
//  Created by P. Nam on 19/06/2024.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject fileprivate var viewModel: HomeViewModel
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        contentView
            .onAppear {
                Task(priority: .utility) {
                    await viewModel.loadVideos()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    leadingView
                }
            }
    }
    
    @ViewBuilder private var leadingView: some View {
        HStack(spacing: 4) {
            Image(ImageResource.youtubeFill)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(Strings.PNYoutube.HomePage.leadingTitle)
                .foregroundColor(.black)
                .font(.system(size: 16))
                .bold()
        }
    }
    
    @ViewBuilder private var contentView: some View {
        StateView(state: $viewModel.sections) { data in
            List(Array(data.enumerated()), id: \.offset) { index, item in
                itemView(data, item: item, index: index)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                    .listRowSpacing(0)
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .refreshable {
                await viewModel.loadVideos()
            }
        }
    }
    
    @ViewBuilder private func itemView(_ data: [HomeSection], item: HomeSection, index: Int) -> some View {
        switch item {
        case .regular(let video):
            regularVideo(data, item: video, index: index)
        case .shorts(let videos):
            shortLayoutVideos(items: videos)
        }
    }
    
    @ViewBuilder private func regularVideo(_ data: [HomeSection], item: FetchHomeVideosResonse, index: Int) -> some View {
        RegularYoutubeItemView(item: item)
            .padding(.bottom, data[index].isRegular ? 16 : 0)
    }
    
    @ViewBuilder private func shortLayoutVideos(items: [FetchHomeVideosResonse]) -> some View {
        Section {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.id) { item in
                    ShortYoutubeItemView(item: item)
                }
            }
        } header: {
            HStack(spacing: 8) {
                Image(ImageResource.youtubeShortsFill)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                Text(Strings.PNYoutube.HomePage.shortsTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

extension HomeView {
    static func create(viewModel: HomeViewModel) -> Self {
        HomeView(viewModel: viewModel)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(useCase: PNAppDelegate.resolve()))
}
