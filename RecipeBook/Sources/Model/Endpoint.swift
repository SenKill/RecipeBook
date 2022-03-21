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
    static func search(for search: SearchType,
                       matching query: String? = nil,
                       count number: Int,
                       tags: [String] = [],
                       type: String? = nil,
                       filter: FilterParameters? = nil) -> Endpoint {
        var endpoint: Endpoint
        
        // Checking search type passed in with method parameters for initializing the endpoint
        switch search {
        case .random:
            endpoint = Endpoint(
                path: search.rawValue,
                queryItems: [
                    URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                    URLQueryItem(name: "number", value: String(number)),
                ]
            )
            if tags != [] {
                // Converting array of strings to single string for QueryItem
                var tagsInString: String = ""
                for tag in tags {
                    if tag != tags.last {
                        tagsInString += tag.lowercased() + ","
                    } else {
                        tagsInString += tag.lowercased()
                    }
                }
                endpoint.queryItems.append(URLQueryItem(name: "tags", value: tagsInString))
            }
        case .complexSearch:
            endpoint = Endpoint(
                path: search.rawValue,
                queryItems: [
                    URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "number", value: String(number)),
                    URLQueryItem(name: "instructionsRequired", value: "true"),
                    URLQueryItem(name: "addRecipeInformation", value: "true"),
                    URLQueryItem(name: "type", value: type),
                    URLQueryItem(name: "cuisine", value: filter?.cuisine),
                    URLQueryItem(name: "diet", value: filter?.diet)
                ]
            )
        default:
            endpoint = Endpoint(
                path: search.rawValue,
                queryItems: [
                    URLQueryItem(name: "apiKey", value: APIKeys.spoonacular),
                    URLQueryItem(name: "number", value: String(number))
                ]
            )
        }
        
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
