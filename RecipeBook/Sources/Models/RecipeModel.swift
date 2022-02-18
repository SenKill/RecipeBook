//
//  RecipeModel.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation

struct RecipeModel {
    let name: String
    let image: String
    let author: String
    let prepTime: Int
    let isFavorite: Bool
    let servings: Int
    let calories: Int
    let ingridientsCount: Int
}

class RecipeData {
    // Temperary data
    func getMealRecipes() -> [RecipeModel] {
        return [
            RecipeModel(
                name: "Omelet",
                image: "omelet",
                author: "Food Network",
                prepTime: 20,
                isFavorite: false,
                servings: 2,
                calories: 350,
                ingridientsCount: 4
            ),
            RecipeModel(
                name: "Bostom Creamy Pancakes",
                image: "pancake",
                author: "Delish",
                prepTime: 20,
                isFavorite: true,
                servings: 4,
                calories: 270,
                ingridientsCount: 5
            ),
            RecipeModel(
                name: "Quick and Easy Breakfast",
                image: "breakfast",
                author: "Honest Cooking",
                prepTime: 20,
                isFavorite: false,
                servings: 5,
                calories: 500,
                ingridientsCount: 4
            )
        ]
    }
    
    func getPopularRecipes() -> [RecipeModel] {
        return [
            RecipeModel(
                name: "Best Ever Bolognese Sauce",
                image: "1",
                author: "Foodista",
                prepTime: 45,
                isFavorite: false,
                servings: 3,
                calories: 247,
                ingridientsCount: 5
            ),
            
            RecipeModel(
                name: "Mint Chocolate Chip Ice Cream",
                image: "2",
                author: "Foodista",
                prepTime: 45,
                isFavorite: false,
                servings: 5,
                calories: 450,
                ingridientsCount: 3
            ),
            
            RecipeModel(
                name: "Chicken with Grape Tomatoes and Mushrooms",
                image: "3",
                author: "Foodista",
                prepTime: 45,
                isFavorite: false,
                servings: 4,
                calories: 575,
                ingridientsCount: 7
            ),
            
            RecipeModel(
                name: "Dreamy Chai Rice Pudding",
                image: "4",
                author: "Foodista",
                prepTime: 45,
                isFavorite: false,
                servings: 3,
                calories: 195,
                ingridientsCount: 5
            ),
            
            RecipeModel(
                name: "Triple Citrus Cake",
                image: "5",
                author: "Foodista",
                prepTime: 45,
                isFavorite: false,
                servings: 1,
                calories: 454,
                ingridientsCount: 6
            )
        ]
    }
}
