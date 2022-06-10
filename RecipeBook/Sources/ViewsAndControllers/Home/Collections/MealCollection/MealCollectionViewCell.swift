//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class MealCollectionViewCell: RecipesCollectionViewCell {
    static let reuseId = "MealCollectionViewCell"
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .secondaryLabel
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        contentView.addSubview(mainImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(favoriteButton)
    }
    
    override func layoutViews() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 5),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 13),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }
    
    override func configureCell(for recipe: Recipe?, with image: UIImage?) {
        super.configureCell(for: recipe, with: image)
        guard let recipe = recipe else {
            return
        }
        recipeNameLabel.backgroundColor = .clear
        authorNameLabel.backgroundColor = .clear
        
        authorNameLabel.text = "by: " + (recipe.sourceName ?? "uknown")
        recipeNameLabel.text = recipe.title
        if let isFavorite = recipe.isFavorite, isFavorite {
            favoriteButton.setActive()
        }
    }
}

// MARK: - Cell Life Cycle
extension MealCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        recipeNameLabel.text = nil
        recipeNameLabel.text = nil
        authorNameLabel.text = nil
        index = nil
        favoriteButton.setInactive()
    }
}
