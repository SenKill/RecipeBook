//
//  UIActivityIndicatorView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/6/22.
//

import UIKit

extension UIActivityIndicatorView {
    func setUpSpinner(loadingImageView: UIImageView) {
        let spinner = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: loadingImageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingImageView.centerYAnchor).isActive = true
    }
}
