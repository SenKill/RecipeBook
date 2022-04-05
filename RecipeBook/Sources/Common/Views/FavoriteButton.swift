//
//  FavoriteButton.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/3/22.
//

import Foundation
import UIKit

protocol FavoriteCollectionButtonDelegate: class {
    func didTapFavoriteButton(_ cell: RecipesCollectionViewCell)
}

protocol FavoriteTableButtonDelegate: class {
    func didTapFavoriteButton(_ cell: RecipesTableViewCell)
}

class FavoriteButton: UIButton {
    private var iconConfiguration: UIImage.SymbolConfiguration!
    
    init(iconPointSize: CGFloat = 25) {
        super.init(frame: .zero)
        
        iconConfiguration = UIImage.SymbolConfiguration(pointSize: iconPointSize, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "heart", withConfiguration: iconConfiguration)
        setImage(image, for: .normal)
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setActive() {
        setImage(UIImage(systemName: "heart.fill", withConfiguration: iconConfiguration), for: .normal)
        tintColor = .systemRed
    }
    
    func setInactive() {
        setImage(UIImage(systemName: "heart", withConfiguration: iconConfiguration), for: .normal)
        tintColor = .white
    }
}
