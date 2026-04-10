//
//  NetworkManager.swift
//  MyAdetApp
//
//  Created by Дастан Жалгас on 09.12.2025.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()

    func fetchRandomQuote(completion: @escaping (Quote) -> Void) {
        guard let url = URL(
                string: "https://zenquotes.io/api/random") else { return }
        
        DispatchQueue.global().async{
            let task = self.session.dataTask(with: url) { data, response, error in
                guard let data = data else { return }

                do {
                    let quote = try JSONDecoder().decode(Quote.self, from: data)
                    DispatchQueue.main.async {
                        completion(quote)
                    }
                } catch {
                    print("error decoding JSON: \(error)")
                }
            }

            task.resume()
        }
    }
}
