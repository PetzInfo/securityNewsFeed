//
//  FetchDataService.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 10.06.24.
//

import Foundation

class FetchDataService {
    static let shared = FetchDataService()
    
    private let apiUrl: URL
    private let username: String
    private let password: String
    
    private init() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any],
              let apiUrlString = config["API_URL"] as? String,
              let url = URL(string: apiUrlString),
              let username = config["API_USERNAME"] as? String,
              let password = config["API_PASSWORD"] as? String else {
            fatalError("Failed to load configuration")
        }
        
        self.apiUrl = url
        self.username = username
        self.password = password
    }
    
    func fetchNews(completion: @escaping (Result<[NewsItem], Error>) -> Void) {
        var request = URLRequest(url: apiUrl)
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])
                completion(.failure(error))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(apiResponse.news))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
