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
    let secondaryText = UIColor(named: "SecondaryTextColor")!
}
