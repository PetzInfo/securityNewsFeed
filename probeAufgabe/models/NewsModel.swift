//
//  NewsModel.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 08.06.24.
//

import Foundation

struct NewsResponse: Decodable {
    let news: [NewsItem]
}

struct NewsItem: Codable, Identifiable {
    var id: UUID { UUID() } // unique ID for SwiftUI List
    let articleID: Int
    let category: Category
    let imageURLs: [ImageURL]
    let releasedate: String
    let subtitle: String?
    let title: String
    let video: Video?
    var isRead: Bool = false
    
    struct Category: Codable {
        let iconURL: String
        let name: String
    }
    
    struct ImageURL: Codable {
        let imageURL: String
    }
    
    struct Video: Codable {}
}
