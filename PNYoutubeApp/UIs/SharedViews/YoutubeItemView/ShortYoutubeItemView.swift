//
//  ShortYoutubeItemView.swift
//  PNYoutube
//
//  Created by P. Nam on 21/06/2024.
//

import SwiftUI
import Kingfisher

struct ShortYoutubeItemView: View {
    private let item: FetchHomeVideosResonse
    
    init(item: FetchHomeVideosResonse) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            thumbnail
            
            details
        }
        .cornerRadius(8)
    }
    
    @ViewBuilder private var thumbnail: some View {
        Color.black.overlay {
            KFImage.url(URL(string: item.snippet.thumbnails.standard.url))
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
        }
        .aspectRatio(9.0 / 16.0, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    @ViewBuilder private var details: some View {
        VStack {
            Button {
                
            } label: {
                Color.clear.overlay {
                    Image(ImageResource.ellipsisVerticalFill)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(.white)
                        .shadow(
                            color: .black.opacity(0.7),
                            radius: 3,
                            x: 0,
                            y: 2
                        )
                        .frame(height: 16)
                }
                .frame(width: 16, height: 16)
                .padding(.leading, 8)
                .padding(.bottom, 8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer()
            
            Text(item.snippet.title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                .shadow(
                    color: .black.opacity(0.7),
                    radius: 3,
                    x: 0,
                    y: 2
                )
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: .infinity)
        .padding(8)
    }
}
