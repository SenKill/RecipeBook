//
//  Constants.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation
import UIKit


struct Constants {
    static let mealRows: Int = 15
    static let popularRows: Int = 10
    static let searchDefaultRows: Int = 3
    static let searchRows: Int = 10
    
    static let leftDistance: CGFloat = 20
    static let rightDistance: CGFloat = 20
    
    static let mealMinimumLineSpacing: CGFloat = 10
    static let mealItemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - (Constants.mealMinimumLineSpacing / 2)) / 3
    static let mealCollectionHeight = mealItemWidth + UIScreen.main.bounds.height * 0.07
    
    static let popularMinimumLineSpacing: CGFloat = 15
    static let popularItemWidth: CGFloat = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance)
    static let popularItemHeight: CGFloat = (UIScreen.main.bounds.height - (Constants.popularMinimumLineSpacing / 2)) / 6
    static let popularCollectionHeight: CGFloat = (popularItemHeight + popularMinimumLineSpacing) * CGFloat(popularRows) + 50
}
