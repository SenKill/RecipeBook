//
//  FavoritesTableViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/4/22.
//

import Foundation
import UIKit

class FavoritesTableViewCell: RecipesTableViewCell {
    static let reuseId = "FavoritesTableViewCell"
    
    override func layoutViews() {
        super.layoutViews()
        recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance).isActive = true
    }
}
