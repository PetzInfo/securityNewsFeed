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
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(newsItem: NewsItem(
            articleID: 1,
            category: NewsItem.Category(iconURL: "", name: "Sample Category"),
            imageURLs: nil,
            releasedate: "01.01.2024",
            subtitle: "This is a sample subtitle for the news item.",
            title: "Sample News Title",
            video: nil
        ))
    }
}
