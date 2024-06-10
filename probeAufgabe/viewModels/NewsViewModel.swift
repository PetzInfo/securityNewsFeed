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
                    self.news = newsList
                    self.lastUpdate = Date()
                    NewsStorage.shared.saveNews(newsList)
                case .failure(let error):
                    print("Failed to load news: \(error)")
                    self.news = NewsStorage.shared.loadNews()
                }
                self.isLoading = false
            }
        }
    }
}
