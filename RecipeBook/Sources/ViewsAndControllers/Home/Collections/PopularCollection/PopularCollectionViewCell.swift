//
//  PopularCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/17/22.
//

import UIKit

class PopularCollectionViewCell: RecipesCollectionViewCell {
    static let reuseId = "PopularCollectionViewCell"
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.textColor = .label
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.secondaryLabel
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prepTimeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let prepTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .label
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let servingsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "smallcircle.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let servingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .label
        label.backgroundColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        backgroundColor = UIColor.theme.popularCell
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(prepTimeImageView)
        contentView.addSubview(prepTimeLabel)
        contentView.addSubview(servingsImageView)
        contentView.addSubview(servingsLabel)
        contentView.addSubview(favoriteButton)
    }
    
    override func layoutViews() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            recipeNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5),
            recipeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            authorNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -15),
            authorNameLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 5),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            prepTimeImageView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            prepTimeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            prepTimeImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            prepTimeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            
            prepTimeLabel.leadingAnchor.constraint(equalTo: prepTimeImageView.trailingAnchor, constant: 5),
            prepTimeLabel.topAnchor.constraint(equalTo: prepTimeImageView.topAnchor, constant: 5),
            prepTimeLabel.bottomAnchor.constraint(equalTo: prepTimeImageView.bottomAnchor, constant: -5),
            prepTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            
            servingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            servingsLabel.topAnchor.constraint(equalTo: servingsImageView.topAnchor, constant: 5),
            servingsLabel.bottomAnchor.constraint(equalTo: servingsImageView.bottomAnchor, constant: -5),
            servingsLabel.widthAnchor.constraint(equalToConstant: 75),
            
            servingsImageView.trailingAnchor.constraint(equalTo: servingsLabel.leadingAnchor, constant: -5),
            servingsImageView.centerYAnchor.constraint(equalTo: prepTimeImageView.centerYAnchor),
            servingsImageView.widthAnchor.constraint(equalTo: prepTimeImageView.widthAnchor),
            servingsImageView.heightAnchor.constraint(equalTo: prepTimeImageView.heightAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
        ])
    }
    
    override func configureCell(for recipe: Recipe?, with image: UIImage?) {
        super.configureCell(for: recipe, with: image)
        
        recipeNameLabel.backgroundColor = .clear
        authorNameLabel.backgroundColor = .clear
        servingsLabel.backgroundColor = .clear
        prepTimeLabel.backgroundColor = .clear
        
        guard let recipe = recipe else {
            return
        }
        recipeNameLabel.text = recipe.title
        authorNameLabel.text = "by: " + (recipe.sourceName ?? "uknown")
        prepTimeLabel.text = "\(recipe.readyInMinutes) Min"
        servingsLabel.text = String(recipe.servings) + (recipe.servings == 1 ? " Serving" : " Servings")
        if let isFavorite = recipe.isFavorite, isFavorite {
            favoriteButton.setActive()
        }
    }
}

// MARK: - Cell Life Cycle
extension PopularCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        recipeNameLabel.text = nil
        authorNameLabel.text = nil
        prepTimeLabel.text = nil
        servingsLabel.text = nil
        index = nil
        favoriteButton.setInactive()
    }
}
