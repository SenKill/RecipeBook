//
//  SearchType.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import Foundation

enum SearchType: String {
    case complexSearch = "/recipes/complexSearch"
    case findByNutrients = "/recipes/findByNutrients"
    case findByIngredients = "/recipes/findByIngredients"
    case random = "/recipes/random"
}
