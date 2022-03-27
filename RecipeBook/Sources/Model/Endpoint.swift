//
//  Endpoint.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/28/22.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem]
}

extension Endpoint {
    static func randomSearch(number: Int, tags: [String] = []) -> Endpoint {
        let endpoint = Endpoint(
            path: SearchType.random.rawValue,
            queryItems: [
                URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                URLQueryItem(name: "number", value: String(number)),
                URLQueryItem(name: "tags", value: tags.convertStringArrayToString())
            ]
        )
        return endpoint
    }
    
    static func searchWithFilter(_ filter: FilterParameters, query: String?, number: Int) -> Endpoint {
        let maxCalories: String = filter.maxCalories == nil ? "10000" : String(filter.maxCalories!)
        let endpoint = Endpoint(
            path: SearchType.complexSearch.rawValue,
            queryItems: [
                URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: String(number)),
                URLQueryItem(name: "instructionsRequired", value: "true"),
                URLQueryItem(name: "addRecipeNutrition", value: "true"),
                URLQueryItem(name: "type", value: filter.type),
                URLQueryItem(name: "cuisine", value: filter.cuisine),
                URLQueryItem(name: "diet", value: filter.diet),
                URLQueryItem(name: "intolerances", value: filter.intolerances.convertStringArrayToString()),
                URLQueryItem(name: "maxCalories", value: maxCalories),
                URLQueryItem(name: "sort", value: filter.sort)
            ]
        )
        return endpoint
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
