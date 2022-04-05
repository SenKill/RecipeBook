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
        label.textColor = UIColor.theme.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.secondaryLabel
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
        label.textColor = UIColor.theme.primaryText
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
        label.textColor = UIColor.theme.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(prepTimeImageView)
        contentView.addSubview(prepTimeLabel)
        contentView.addSubview(servingsImageView)
        contentView.addSubview(servingsLabel)
    }
    
    override func layoutViews() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 3),
            
            prepTimeImageView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            prepTimeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            prepTimeImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            prepTimeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            
            prepTimeLabel.leadingAnchor.constraint(equalTo: prepTimeImageView.trailingAnchor, constant: 5),
            prepTimeLabel.topAnchor.constraint(equalTo: prepTimeImageView.topAnchor),
            prepTimeLabel.bottomAnchor.constraint(equalTo: prepTimeImageView.bottomAnchor),
            
            servingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            servingsLabel.topAnchor.constraint(equalTo: servingsImageView.topAnchor),
            servingsLabel.bottomAnchor.constraint(equalTo: servingsImageView.bottomAnchor),
            
            servingsImageView.trailingAnchor.constraint(equalTo: servingsLabel.leadingAnchor, constant: -5),
            servingsImageView.topAnchor.constraint(equalTo: prepTimeLabel.topAnchor),
            servingsImageView.widthAnchor.constraint(equalTo: prepTimeImageView.widthAnchor),
            servingsImageView.heightAnchor.constraint(equalTo: prepTimeImageView.heightAnchor)
        ])
    }
}

extension PopularCollectionViewCell: ConfigurableCell {
    func configureCell(for recipe: Recipe?, with image: UIImage?) {
        removeContentFromCell()
        
        // Setting up spinner if image didn't load yet
        if let image = image {
            isImageLoaded = true
            spinner.removeFromSuperview()
            mainImageView.image = image
        } else {
            addSubview(spinner)
            spinner.setUpSpinner(loadingImageView: mainImageView)
        }
        
        guard let recipe = recipe else {
            return
        }
        
        recipeNameLabel.text = recipe.title
        authorNameLabel.text = "by: " + (recipe.sourceName ?? "")
        prepTimeLabel.text = "\(recipe.readyInMinutes) Min"
        servingsLabel.text = "\(recipe.servings) Servings"
    }
    
    private func removeContentFromCell() {
        mainImageView.image = nil
        recipeNameLabel.text = nil
        authorNameLabel.text = nil
        prepTimeLabel.text = nil
        servingsLabel.text = nil
        index = nil
    }
}
