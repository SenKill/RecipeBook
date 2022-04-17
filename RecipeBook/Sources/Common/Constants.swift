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
    static let mealCollectionHeight =  UIScreen.main.bounds.height / 5
    static let mealItemWidth = mealCollectionHeight - UIScreen.main.bounds.width * 0.07
    
    static let popularMinimumLineSpacing: CGFloat = 15
    static let popularItemWidth: CGFloat = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance)
    static let popularItemHeight: CGFloat = (UIScreen.main.bounds.height - (Constants.popularMinimumLineSpacing / 2)) / 6
    static let popularCollectionHeight: CGFloat = (popularItemHeight + popularMinimumLineSpacing) * CGFloat(popularCount) + 50
    
    static let ingrMinimumLineSpacing: CGFloat = 20
    
    static let homeBackgroundHeight: CGFloat = UIScreen.main.bounds.height / 2
}
