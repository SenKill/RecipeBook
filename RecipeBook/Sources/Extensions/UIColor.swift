//
//  UIColor.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

class ColorTheme {
    let background = UIColor(named: "BackgroundColor")!
    let gradientBackgroundFirst = UIColor(named: "GradientColorFirst")!
    let gradientBackgroundSecond = UIColor(named: "GradientColorSecond")!
    let tagViewBackground = UIColor(named: "TagViewBackground")!
    let tagViewBackgroundSelected = UIColor(named: "TagViewBackgroundSelected")!
    
    let primaryText = UIColor(named: "PrimaryTextColor")!
    let secondaryText = UIColor(named: "SecondaryTextColor")!
    
    let divider = UIColor.systemGray2.withAlphaComponent(0.5)
    
    let primaryTintColor = UIColor(named: "PrimaryGreenColor")!.withAlphaComponent(0.9)
}
