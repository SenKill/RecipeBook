//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/5/22.
//

import Foundation
import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    var index: IndexPath!
    var isImageLoaded: Bool = false
    weak var delegate: FavoriteButtonDelegate?
    
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
        let button = FavoriteButton(iconPointSize: 20)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = .zero
        
        button.layer.borderColor = UIColor.black.cgColor
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
    
    func setViews() {
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton(_:)), for: .touchUpInside)
    }
    
    func layoutViews() {
        
    }
}

// MARK: - Internal
private extension RecipesCollectionViewCell {
    @objc func didTapFavoriteButton(_ sender: FavoriteButton) {
        delegate?.didTapFavoriteButton(sender, index: index)
    }
}
