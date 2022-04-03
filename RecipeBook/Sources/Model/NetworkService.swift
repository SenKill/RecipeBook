//
//  NetworkService.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import Foundation
import UIKit

final class NetworkService {
    static func fetchRecipes(_ endpoint: Endpoint, then handler: @escaping (Result<RecipeModel, Error>) -> Void)  {
        // Unwrapping optional property from endpoint
        guard let url = endpoint.url else {
            handler(.failure(NetworkError.wrongUrl))
            return
        }
        print(url)
        // Calling URLSessian.dataTask for getting data with given url
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            }
            
            guard let data = data else {
                handler(.failure(NetworkError.notFoundData))
                return
            }
            
            // Trying to decode data because it's formatted in JSON
            do {
                let recipeData = try JSONDecoder().decode(RecipeModel.self, from: data)
                let checkedRecipes = LocalService.shared.checkForFavorites(recipeData)
                handler(.success(checkedRecipes))
            } catch let error as NSError {
                handler(.failure(error))
            }
        }
        .resume()
    }
    
    static func fetchImage(
        for imageType: ImageType,
        with name: String,
        size: String?,
        handler: @escaping (Result<Data, Error>) -> Void) {
        
        let baseURL = "https://spoonacular.com"
        var assembledUrl: String = ""
        
        switch imageType {
        case .recipe:
            assembledUrl = name
        case .ingredient:
            assembledUrl = "\(baseURL + imageType.rawValue)_\(size!)/\(name)"
        }
        
        guard let url = URL(string: assembledUrl) else {
            handler(.failure(NetworkError.wrongUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                handler(.failure(error))
            }
            
            guard let data = data else {
                handler(.failure(NetworkError.notFoundData))
                return
            }
            
            handler(.success(data))
        }
        .resume()
    }
}
