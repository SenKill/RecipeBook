//
//  UIImage.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/9/22.
//

import UIKit

extension UIImage {
    static let images = Images()
}

struct Images {
    let defaultRecipe = UIImage(named: "defaultRecipeImage")
    let homeBackground = UIImage(named: "homeBackgroundImage")
    
    let calories = UIImage(systemName: "flame.fill")!
    let carbs = UIImage(systemName: "leaf.fill") ?? UIImage(systemName: "bolt.fill")!
    let protein = UIImage(systemName: "shield.fill")!
    let fats = UIImage(systemName: "drop.fill") ?? UIImage(systemName: "capsule.fill")!
}
