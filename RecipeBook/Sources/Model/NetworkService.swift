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
        guard let url = endpoint.url else {
            handler(.failure(NetworkError.wrongUrl))
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            }
            
            guard let data = data else {
                handler(.failure(NetworkError.notFoundData))
                return
            }
            
            do {
                let recipeData = try JSONDecoder().decode(RecipeModel.self, from: data)
                handler(.success(recipeData))
            } catch let error as NSError {
                handler(.failure(error))
            }
        }
        .resume()
    }
    
    static func fetchImage(
        for imageType: ImageType,
        from name: String,
        size: String?,
        handler: @escaping (Result<Data, Error>) -> Void) {
        let baseURL = "https://spoonacular.com"
        var assembledUrl: String = ""
        
        switch imageType {
        case .recipe:
            assembledUrl = name
        case .ingridient:
            assembledUrl = "\(baseURL + imageType.rawValue)_\(size!)/"
        default:
            handler(.failure(NetworkError.wrongImageType))
        }
        
        guard let url = URL(string: assembledUrl) else {
            print(NetworkError.wrongUrl)
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
