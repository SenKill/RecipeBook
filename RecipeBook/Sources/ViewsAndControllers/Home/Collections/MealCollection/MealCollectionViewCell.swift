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
        label.text = "Loading..."
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .secondaryLabel
        label.text = "by: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        
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
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            recipeNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            authorNameLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 3),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }
}

// MARK: - Cell Life Cycle
extension MealCollectionViewCell: ConfigurableCell {
    func configureCell(for recipe: Recipe?, with image: UIImage?) {
        // Setting up spinner if image didn't load yet
        if let image = image {
            isImageLoaded = true
            spinner.removeFromSuperview()
            mainImageView.image = image
        } else {
            mainImageView.addSubview(spinner)
            // Custom method from extension
            spinner.setUpSpinner(loadingImageView: mainImageView)
        }
        
        guard let recipe = recipe else {
            return
        }
        
        authorNameLabel.text = "by: " + (recipe.sourceName ?? "uknown")
        recipeNameLabel.text = recipe.title
        if let isFavorite = recipe.isFavorite, isFavorite {
            favoriteButton.setActive()
        }
    }
    
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
