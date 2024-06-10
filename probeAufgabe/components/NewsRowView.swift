//
//  NwesRowView.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 10.06.24.
//

import SwiftUI

struct NewsRowView: View {
    let newsItem: NewsItem
    
    var body: some View {
        HStack {
            if let video = newsItem.video, video.videoURL != nil {
                Image(systemName: "video")
                    .resizable()
                    .frame(width: 50, height: 50)
            } else if let imageURLs = newsItem.imageURLs, let firstImageURL = imageURLs.first?.imageURL, let url = URL(string: firstImageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 50, height: 50)
            } else {
                AsyncImage(url: URL(string: newsItem.category.iconURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 50)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(newsItem.title)
                    .font(.headline)
                Text(newsItem.releasedate)
                    .font(.subheadline)
                if let subtitle = newsItem.subtitle {
                    Text(subtitle)
                        .font(.body)
                        .lineLimit(3)
                }
            }
            Spacer()
            if newsItem.isRead == false {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
            }
        }
        .padding()
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(newsItem: NewsItem(
            articleID: 1,
            category: NewsItem.Category(iconURL: "https://example.com/icon.png", name: "Sample Category"),
            imageURLs: [NewsItem.ImageURL(imageURL: "https://example.com/image.png")],
            releasedate: "01.01.2024",
            subtitle: "This is a sample subtitle for the news item.",
            title: "Sample News Title",
            video: NewsItem.Video(videoURL: "https://example.com/video.mp4"),
            isRead: false
        ))
    }
}
