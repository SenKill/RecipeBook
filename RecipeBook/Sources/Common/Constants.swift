//
//  Constants.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation
import UIKit


struct Constants {
    static let mealCount: Int = 15
    static let popularCount: Int = 10
    static let searchDefaultCount: Int = 3
    static let searchCount: Int = 10
    
    static let leftDistance: CGFloat = 20
    static let rightDistance: CGFloat = 20
    
    static let mealMinimumLineSpacing: CGFloat = 10
    static let mealItemWidth: CGFloat = 100 + (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - mealMinimumLineSpacing) * 0.05
    static let mealCollectionHeight: CGFloat = mealItemWidth + 40
    
    static let popularMinimumLineSpacing: CGFloat = 15
    static let popularItemWidth: CGFloat = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance)
    static let popularItemHeight: CGFloat = popularItemWidth / 3
    static let popularCollectionHeight: CGFloat = (popularItemHeight + popularMinimumLineSpacing) * CGFloat(popularCount) + 50
    
    static let ingrMinimumLineSpacing: CGFloat = 20
}
