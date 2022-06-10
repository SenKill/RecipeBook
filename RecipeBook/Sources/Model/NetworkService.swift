//
//  NetworkService.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import Foundation
import UIKit

final class NetworkService {
    static let shared = NetworkService()
    
    var imageCache = NSCache<NSString, NSData>()
    
    func fetchRecipes(_ endpoint: Endpoint, then completion: @escaping (Result<RecipeModel, Error>) -> Void)  {
        // Unwrapping optional property from endpoint
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.wrongUrl))
            return
        }
        
        // Trying to decode data because it's formatted in JSON
        loadDataFromUrl(url) { result in
            switch result {
            case .success(let data):
                do {
                    let recipeData = try JSONDecoder().decode(RecipeModel.self, from: data)
                    let checkedRecipes = LocalService.shared.checkForFavorites(recipeData)
                    completion(.success(checkedRecipes))
                } catch let error as NSError {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage(
        for imageType: ImageType,
        with name: String,
        size: String?,
        completion: @escaping (Result<Data, Error>) -> Void) {
            let baseURL = "https://spoonacular.com"
            var assembledUrl: String = ""
            
            switch imageType {
            case .recipe:
                assembledUrl = name
            case .ingredient:
                assembledUrl = "\(baseURL + imageType.rawValue)_\(size!)/\(name)"
            }
            
            guard let url = URL(string: assembledUrl) else {
                completion(.failure(NetworkError.wrongUrl))
                return
            }
            
            if let cachedImageData = imageCache.object(forKey: url.absoluteString as NSString) as? Data {
                print("Loading from cache")
                completion(.success(cachedImageData))
                return
            }
            
            loadDataFromUrl(url) { result in
                print("Image loaded")
                if let data = try? result.get() as NSData {
                    self.imageCache.setObject(data, forKey: url.absoluteString as NSString)
                }
                completion(result)
            }
        }
    
    private func loadDataFromUrl(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
        // Calling URLSessian.dataTask for getting data with given url
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...300).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.wrongStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.notFoundData))
                return
            }
            completion(.success(data))
        }
        .resume()
    }
}
