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
    
    static func getRecipes() -> [RecipeModel] {
        return []
    }
}
