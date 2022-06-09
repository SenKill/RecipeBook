//
//  LocalService.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/3/22.
//

import Foundation

final class LocalService {
    static let shared = LocalService()
    
    private let defaults = UserDefaults.standard
    
    func getFavorites() -> [Recipe] {
        let decoder = JSONDecoder()
        
        if let fetchedData = defaults.object(forKey: UserDefaults.keys.favorites) as? Data,
           let favorites = try? decoder.decode([Recipe].self, from: fetchedData) {
            return favorites
        }
        return []
    }
    
    func addToFavorites(_ recipe: Recipe) {
        var recipe = recipe
        let encoder = JSONEncoder()
        var favorites = getFavorites()
        
        recipe.isFavorite = true
        favorites.append(recipe)
        guard let encodedData = try? encoder.encode(favorites) else {
            print("ERROR: Can't encode data")
            return
        }
        defaults.set(encodedData, forKey: UserDefaults.keys.favorites)
        print("Favorite recipes count: \(favorites.count)")
    }
    
    func removeObjectFromFavorites(with id: Int) {
        var favorites = getFavorites()
        
        for recipe in favorites {
            if recipe.id == id {
                print("Removing - \(recipe.title)")
                if let index = favorites.firstIndex(of: recipe) {
                    favorites.remove(at: index)
                }
            }
        }
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(favorites) else {
            print("ERROR: Can't encode data")
            return
        }
        defaults.set(encodedData, forKey: UserDefaults.keys.favorites)
    }
    
    func checkForFavorites(_ recipeModel: RecipeModel?) -> RecipeModel {
        var checkableRecipes: [Recipe] = []
        var isResults: Bool = false
        
        // Checking which one property needs to be checked, cause there are may be 2 alternative properties
        if let recipes = recipeModel?.recipes {
            checkableRecipes = recipes
        }
        if let results = recipeModel?.results {
            checkableRecipes = results
            isResults = true
        }
        
        let favorites = getFavorites()
        for recipeIndex in 0..<checkableRecipes.count {
            for favoriteIndex in 0..<favorites.count {
                if checkableRecipes[recipeIndex] == favorites[favoriteIndex] {
                    checkableRecipes[recipeIndex].isFavorite = true
                }
            }
        }
        
        if isResults {
            return RecipeModel(recipes: nil, results: checkableRecipes)
        }
        return RecipeModel(recipes: checkableRecipes, results: nil)
    }
}
