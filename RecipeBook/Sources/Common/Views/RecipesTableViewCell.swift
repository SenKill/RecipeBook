//
//  RecipesTableViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/4/22.
//

import Foundation
import UIKit

class RecipesTableViewCell: UITableViewCell {
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = UIColor.theme.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        clipsToBounds = false
        backgroundColor = UIColor.theme.background
        contentView.addSubview(mainImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(authorLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            recipeNameLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 3),
            
            infoLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            infoLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            
            authorLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            authorLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func configureCell(for recipe: Recipe?, with image: UIImage?) {
        let cell = self
        
        // Setting up spinner if image didn't load yet
        if let image = image {
            spinner.removeFromSuperview()
            cell.mainImageView.image = image
        } else {
            cell.mainImageView.addSubview(spinner)
            spinner.setUpSpinner(loadingImageView: mainImageView)
        }
        
        guard let recipe = recipe else {
            return
        }
        
        recipeNameLabel.text = recipe.title
        
        let prepTime = recipe.readyInMinutes
        var dishTypes = ""
        
        for dishType in recipe.dishTypes {
            dishTypes += " · " + dishType
        }
        
        cell.infoLabel.text = "\(prepTime)m" + dishTypes
        cell.authorLabel.text = "by: " + (recipe.sourceName ?? "")
    }
}

extension RecipesTableViewCell {
    override func prepareForReuse() {
        mainImageView.image = nil
        recipeNameLabel.text = nil
        infoLabel.text = nil
        authorLabel.text = nil
    }
}

