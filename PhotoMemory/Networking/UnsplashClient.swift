// 

import Foundation
import UIKit


struct UnsplashClient {
        
    #error("Insert valid key for UnsplashClient. See https://unsplash.com/documentation#public-authentication")
    private let clientId = "YOUR_ACCESS_KEY"
    private let urlBase = "https://api.unsplash.com"
    
    func search(query: String, completion: @escaping (Result<[URL], Error>) -> Void) {
        let url = searchURL(query: query)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                let error = error ?? UnsplashError.unknownError
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            let decoder = JSONDecoder()

            if let responseObject = try? decoder.decode(SearchResponse.self, from: data) {
                let urls = responseObject.results.compactMap{ URL(string:$0.urls.regular) }
                DispatchQueue.main.async {
                    completion(.success(urls))
                }
            } else if let errorObject = try? decoder.decode(ErrorResponse.self, from: data) {
                let errorMessage = errorObject.errors.joined(separator: "\n")
                DispatchQueue.main.async {
                    completion(.failure(UnsplashError.serverError(message: errorMessage)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(UnsplashError.unknownError))
                }
            }
        }
        task.resume()
    }
    
    func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = UnsplashError.imageLoadError(message: "Failed to get image from url data")
                        completion(.failure(error))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
        
    
    private func searchURL(query: String) -> URL {
        let urlString = urlBase + "/search/photos"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "per_page", value: String(50)),
            URLQueryItem(name: "query", value: query)
        ]
        return components.url!
    }
}
