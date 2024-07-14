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
    
    // Load existing news from local storage
    let existingNews = NewsStorage.shared.loadNews()
    
    FetchDataService.shared.fetchNews { result in
        DispatchQueue.main.async {
            switch result {
            case .success(let fetchedNews):
                // Merge fetched news with existing news
                var updatedNews = [NewsItem]()
                
                for fetchedItem in fetchedNews {
                    if let existingItem = existingNews.first(where: { $0.articleID == fetchedItem.articleID }) {
                        // Preserve the isRead status
                        var mutableFetchedItem = fetchedItem
                        mutableFetchedItem.isRead = existingItem.isRead
                        updatedNews.append(mutableFetchedItem)
                    } else {
                        updatedNews.append(fetchedItem)
                    }
                }
                
                // Sort by release date
                self.news = updatedNews.sorted(by: { $0.releasedate > $1.releasedate })
                self.lastUpdate = Date()
                NewsStorage.shared.saveNews(self.news)
                
            case .failure(let error):
                print("Failed to load news: \(error)")
                self.news = existingNews.sorted(by: { $0.releasedate > $1.releasedate })
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
