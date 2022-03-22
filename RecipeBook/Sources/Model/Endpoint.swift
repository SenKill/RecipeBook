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
    
    static func searchWithFilter(_ filter: FilterParameters, query: String, number: Int) -> Endpoint {
        let endpoint = Endpoint(
            path: SearchType.complexSearch.rawValue,
            queryItems: [
                URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: String(number)),
                URLQueryItem(name: "instructionsRequired", value: "true"),
                URLQueryItem(name: "addRecipeInformation", value: "true"),
                URLQueryItem(name: "type", value: filter.type),
                URLQueryItem(name: "cuisine", value: filter.cuisine),
                URLQueryItem(name: "diet", value: filter.diet)
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
