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
            ZStack {
                if let imageURLs = newsItem.imageURLs, !imageURLs.isEmpty {
                    AsyncImage(url: URL(string: imageURLs[0].imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .opacity(0.5)
                    }
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
            }
            
        }
        .padding(16)
        .cornerRadius(16)
        .background(Color.white.opacity(0.8))
        .shadow(radius: 5)
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

