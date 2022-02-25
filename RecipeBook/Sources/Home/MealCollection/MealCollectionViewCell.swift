//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "RecipesCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
    
    func setViews() {
        backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(bookmarkImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(authorNameLabel)
            
    }
    
    func layoutViews() {
        
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
    
    func configureCell(for recipe: RecipeModel) {
        let cell = self
        
        cell.mainImageView.image = UIImage(named: recipe.image)
        cell.recipeNameLabel.text = recipe.name
        cell.authorNameLabel.text = "by: " + recipe.author
        if recipe.isFavorite {
            cell.bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
            cell.bookmarkImageView.tintColor = .systemGreen // or .systemYellow
        }
    }
}
