//
//  RecipesCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "RecipesCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
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
    
    let authorLabel: UILabel = {
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
        backgroundColor = UIColor.theme.background
        contentView.addSubview(mainImageView)
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(authorLabel)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3),
            
            favoriteImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -5),
            favoriteImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 5),
            favoriteImageView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor, multiplier: 0.2),
            favoriteImageView.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.25),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5),
            
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 5)
        ])
    }
}

/*
 Old constraints

 
 
 
 NSLayoutConstraint.activate([
     
     authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
     authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
     authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
     
     recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
     recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
     recipeNameLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -5),
     
     mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
     mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
     mainImageView.topAnchor.constraint(equalTo: topAnchor),
     mainImageView.bottomAnchor.constraint(equalTo: recipeNameLabel.topAnchor, constant: -5),
     
     favoriteImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -5),
     favoriteImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 5),
     favoriteImageView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor, multiplier: 0.2),
     favoriteImageView.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.25)
 ])
 */
