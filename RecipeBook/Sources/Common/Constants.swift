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
    
    static let mealMinimumLineSpacing: CGFloat = 10
    static let mealItemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - (Constants.mealMinimumLineSpacing / 2)) / 3
    static let mealCollectionHeight = (UIScreen.main.bounds.height) / 4
    
    static let popularMinimumLineSpacing: CGFloat = 15
    static let popularItemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - (Constants.mealMinimumLineSpacing / 2))
    static let popularItemHeight = (UIScreen.main.bounds.height - (Constants.popularMinimumLineSpacing / 2)) / 6
}
