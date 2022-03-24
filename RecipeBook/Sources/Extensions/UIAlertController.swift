//
//  UIAlertController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/24/22.
//

import Foundation
import UIKit

extension UIAlertController {
    static func errorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
}
