//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/5/22.
//

import Foundation
import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    var index: Int!
    var isImageLoaded: Bool = false
    weak var delegate: FavoriteCollectionButtonDelegate?
    
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let favoriteButton: FavoriteButton = {
        let button = FavoriteButton(iconPointSize: 25)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() { }
    
    func layoutViews() { }
}
