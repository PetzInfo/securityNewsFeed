//
//  FetchDataService.swift
//  probeAufgabe
//
//  Created by Friedrich Commichau on 10.06.24.
//

import Foundation

class FetchDataService {
    static let shared = FetchDataService()
    private let url = URL(string: "https://staging-probeapi.mobile-software.ag/rohdaten/SecurtiyInfo.json")!
    
    func fetchNews(completion: @escaping (Result<[NewsItem], Error>) -> Void) {
        var request = URLRequest(url: url)
        let username = "aspirant"
        let password = "mein-aller-bestes-probearbeiten!"
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
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No data"])
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
