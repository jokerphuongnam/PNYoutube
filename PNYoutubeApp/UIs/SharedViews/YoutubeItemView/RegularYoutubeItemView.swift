//
//  RegularYoutubeItemView.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import SwiftUI
import Kingfisher

struct RegularYoutubeItemView: View {
    private let item: FetchHomeVideosResonse
    
    init(item: FetchHomeVideosResonse) {
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 16) {
            thumbnailView
                .frame(maxWidth: .infinity)
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
            
            detailsView
                .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder private var thumbnailView: some View {
        let width = UIScreen.main.bounds.width
        ZStack(alignment: .bottomTrailing) {
            Color.black.overlay {
                let thumbnail = item.snippet.thumbnails.closestThumbnail(
                    to: width
                )
                KFImage.url(
                    URL(
                        string: thumbnail.url
                    )
                )
                .placeholder {
                    Color.gray.overlay {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundColor(.white)
                    }
                }
                .loadDiskFileSynchronously()
                .fade(duration: 0.25)
                .lowDataModeSource(
                    .network(URL(string: item.snippet.thumbnails.thumbnailsDefault.url)!)
                )
                .resizable()
                .frame(width: width, height: width * 3.0 / 4.0)
                .scaledToFill()
            }
            .frame(width: width, height: (width * 3.0 / 4.0) - 80)
            .clipped()
            
            Text(item.contentDetails.duration.youtubeTimeToSeconds().toTimeString())
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black.opacity(0.7))
                        .blur(radius: 0.5)
                )
                .clipped()
                .padding(.bottom, 8)
                .padding(.trailing, 8)
        }
    }
    
    @ViewBuilder private var detailsView: some View {
        HStack(spacing: 8) {
            HStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text(item.snippet.title)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        Text(item.snippet.channelTitle + " • ")
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                            .fontWeight(.thin)
                        
                        if let time = item.snippet.publishedAt.dateAgoString() {
                            Text(time)
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                                .fontWeight(.thin)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            VStack {
                Button {
                    
                } label: {
                    Color.clear.overlay {
                        Image(ImageResource.ellipsisVerticalFill)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(height: 16)
                    }
                    .frame(width: 16, height: 16)
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity)
    }
}
