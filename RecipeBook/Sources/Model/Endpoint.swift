//
//  Endpoint.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/28/22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func search(for search: SearchType,
                       matching query: String? = nil,
                       count number: Int) -> Endpoint {
        let endpoint: Endpoint
        
        switch search {
        case .random:
            endpoint = Endpoint(
                path: search.rawValue,
                queryItems: [
                    URLQueryItem(name: "number", value: String(number))
                ]
            )
            break
        default:
            endpoint = Endpoint(
                path: search.rawValue,
                queryItems: [
                    URLQueryItem(name: "number", value: String(number))
                ]
            )
            break
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
