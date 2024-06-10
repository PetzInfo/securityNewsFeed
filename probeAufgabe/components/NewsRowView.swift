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
        ZStack(alignment: .leading) {
            if let imageURLs = newsItem.imageURLs, let firstImageURL = imageURLs.first?.imageURL, let url = URL(string: firstImageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    case .failure:
                        Color.gray // Fallback color if image fails to load
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Color.clear
            }
            
            HStack {
                
                if let video = newsItem.video, video.videoURL != nil {
                    Image("VideoIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                } else if newsItem.imageURLs == nil || newsItem.imageURLs?.isEmpty == true {
                    Image(systemName: "lightbulb")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(newsItem.title)
                        .font(.headline)
                        .padding(.bottom, 2)
                    Text(newsItem.releasedate)
                        .font(.subheadline)
                        .padding(.bottom, 2)
                    if let subtitle = newsItem.subtitle {
                        Text(subtitle)
                            .font(.body)
                            .lineLimit(3)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
                
                
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            
            if newsItem.isRead == false {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 5)
                    .edgesIgnoringSafeArea(.leading)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.horizontal, .top])
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

