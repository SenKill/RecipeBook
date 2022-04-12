//
//  FavoriteButton.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/3/22.
//

import Foundation
import UIKit

protocol FavoriteButtonDelegate: AnyObject {
    func didTapFavoriteButton(_ sender: FavoriteButton, index: IndexPath)
}

class FavoriteButton: UIButton {
    private var iconConfiguration: UIImage.SymbolConfiguration!
    private var defaultColor: UIColor!
    
    init(iconPointSize: CGFloat = 25, withColor color: UIColor = .white) {
        super.init(frame: .zero)
        
        iconConfiguration = UIImage.SymbolConfiguration(pointSize: iconPointSize, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "heart", withConfiguration: iconConfiguration)
        setImage(image, for: .normal)
        self.defaultColor = color
        tintColor = color
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
        tintColor = defaultColor
    }
}
