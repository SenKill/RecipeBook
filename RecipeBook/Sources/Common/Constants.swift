//
//  Constants.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation
import UIKit


struct Constants {
    static let leftDistance: CGFloat = 20
    static let rightDistance: CGFloat = 20
    static let recipesMinimumLineSpacing: CGFloat = 10
    static let recipesItemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - (Constants.recipesMinimumLineSpacing / 2)) / 3
    static let recipesCollectionHeight = (UIScreen.main.bounds.height) / 4
}
