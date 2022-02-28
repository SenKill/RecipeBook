//
//  NetworkService.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import Foundation

final class NetworkService {
    private let baseUrl: String = "https://api.spoonacular.com/recipes"
    var searchType: String = "/random"
    var number: Int = 10
    private var url: URL? {
        return URL(string: "")
    }
    
    static func getRecipes(_ endpoint: Endpoint, then handler: @escaping (Result<RecipeModel, Error>) -> Void)  {
        guard let url = endpoint.url else {
            handler(.failure(NetworkError.wrongUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            
            guard let data = data else {
                handler(.failure(NetworkError.notFoundData))
                return
            }
            
            do {
                let recipeData = try JSONDecoder().decode(RecipeModel.self, from: data)
                print(recipeData.recipes.count)
                handler(.success(recipeData))
            } catch let error as NSError {
                handler(.failure(error))
            }
        }
        .resume()
    }
}
