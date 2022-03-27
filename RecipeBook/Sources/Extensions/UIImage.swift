//
//  UIImage.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/9/22.
//

import UIKit

extension UIImage {
    static let image = Images()
}

struct Images {
    let defaultRecipe = UIImage(named: "defaultRecipeImage")
    
    let calories = UIImage(systemName: "flame.fill")!
    let carbs = UIImage(systemName: "leaf.fill")!
    let protein = UIImage(systemName: "shield.fill")!
    let fats = UIImage(systemName: "bolt.fill")!
}
