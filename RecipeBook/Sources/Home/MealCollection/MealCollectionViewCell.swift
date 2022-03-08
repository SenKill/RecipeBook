//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "RecipesCollectionViewCell"
    private let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.theme.secondaryText
        label.text = "by: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(mainImageView)
        contentView.addSubview(bookmarkImageView)
    }
    
    private func layoutViews() {
        
        NSLayoutConstraint.activate([
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            authorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            recipeNameLabel.bottomAnchor.constraint(equalTo: authorNameLabel.topAnchor, constant: -3),
            
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: recipeNameLabel.topAnchor, constant: -5),
            
            bookmarkImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -10),
            bookmarkImageView.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            bookmarkImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.23),
            bookmarkImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
        ])
    }
}

extension MealCollectionViewCell: ConfigurableCell {
    func configureCell(for recipe: Recipe?, with image: UIImage?) {
        let cell = self
        
        removeContentFromCell(cell)
        
        if let image = image {
            spinner.removeFromSuperview()
            cell.mainImageView.image = image
        } else {
            cell.mainImageView.addSubview(spinner)
            // Custom method from extension
            spinner.setUpSpinner(loadingImageView: mainImageView)
        }
        
        // Setting up spinner if image didn't load yet
        guard let recipe = recipe else {
            return
        }
        
        cell.authorNameLabel.text = "by: " + (recipe.sourceName ?? "")
        cell.recipeNameLabel.text = recipe.title
        
        // TODO: Add isFavorite property
        /*
        if recipe.isFavorite {
            cell.bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
            cell.bookmarkImageView.tintColor = .systemGreen // or .systemYellow
        }
        */
    }
    
    func removeContentFromCell(_ cell: MealCollectionViewCell) {
        cell.mainImageView.image = nil
        cell.bookmarkImageView.image = nil
        cell.recipeNameLabel.text = nil
        cell.recipeNameLabel.text = nil
        cell.authorNameLabel.text = nil
    }
}
