//
//  SearchTableViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import UIKit

class SearchTableViewCell: RecipesTableViewCell {
    
    static let reuseId = "SearchTableViewCell"
    weak var delegate: FavoriteButtonDelegate?
    var index: IndexPath!
    
    let favoriteButton: FavoriteButton = {
        let button = FavoriteButton(iconPointSize: 20, withColor: .secondaryLabel)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setViews() {
        super.setViews()
        contentView.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton(_:)), for: .touchUpInside)
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            recipeNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: recipeNameLabel.topAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor)
        ])
    }
    
    override func configureCell(for recipe: Recipe?, with image: UIImage?) {
        super.configureCell(for: recipe, with: image)
        guard let recipe = recipe else {
            return
        }
        if let isFavorite = recipe.isFavorite, isFavorite {
            favoriteButton.setActive()
        }
    }
}

extension SearchTableViewCell {
    @objc private func didTapFavoriteButton(_ sender: FavoriteButton) {
        delegate?.didTapFavoriteButton(sender, index: index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.setInactive()
    }
}
