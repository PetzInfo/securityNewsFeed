//
//  NewsStorage.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 10.06.24.
//

import Foundation

class NewsStorage {
    static let shared = NewsStorage()
    private let key = "savedNews"
    
    func saveNews(_ news: [NewsItem]) {
        if let encoded = try? JSONEncoder().encode(news) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func loadNews() -> [NewsItem] {
        if let savedNews = UserDefaults.standard.object(forKey: key) as? Data {
            if let decodedNews = try? JSONDecoder().decode([NewsItem].self, from: savedNews) {
                return decodedNews
            }
        }
        return []
    }
}
