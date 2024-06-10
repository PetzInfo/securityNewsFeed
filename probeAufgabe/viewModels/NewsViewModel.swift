//
//  NewsViewModel.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 10.06.24.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var news: [NewsItem] = []
    @Published var isLoading = false
    @Published var lastUpdate: Date?
    
    init() {
        loadNews()
    }
    
    func loadNews() {
        isLoading = true
        NewsService.shared.fetchNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newsList):
                    self.news = newsList.map { item in
                        var mutableItem = item
                        mutableItem.isRead = item.isRead ?? false
                        return mutableItem
                    }.sorted(by: { $0.releasedate > $1.releasedate })
                    self.lastUpdate = Date()
                    NewsStorage.shared.saveNews(self.news)
                case .failure(let error):
                    print("Failed to load news: \(error)")
                    self.news = NewsStorage.shared.loadNews().sorted(by: { $0.releasedate > $1.releasedate })
                }
                self.isLoading = false
            }
        }
    }
    
    func markAsRead(at index: Int) {
        news[index].isRead = true
        NewsStorage.shared.saveNews(news)
    }
}
