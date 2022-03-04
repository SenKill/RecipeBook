//
//  PopularCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/17/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PopularCollectionViewCell"
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubview(bookmarkImageView)
    }
    
    private func layoutViews() {
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
            servingsImageView.heightAnchor.constraint(equalTo: prepTimeImageView.heightAnchor),
            
            bookmarkImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -10),
            bookmarkImageView.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            bookmarkImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23),
            bookmarkImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    func configureCell(for recipe: Recipe, with image: UIImage?) {
        let cell = self
        
        if let image = image {
            spinner.removeFromSuperview()
            cell.mainImageView.image = image
        } else {
            cell.addSubview(spinner)
            setUpSpinner(spinner: spinner)
        }
        cell.recipeNameLabel.text = recipe.title
        cell.authorNameLabel.text = "by: " + (recipe.sourceName ?? "")
        cell.prepTimeLabel.text = "\(recipe.readyInMinutes) Min"
        cell.servingsLabel.text = "\(recipe.servings) Servings"
    }
    
    private func setUpSpinner(spinner: UIActivityIndicatorView) {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor).isActive = true
        spinner.startAnimating()
    }
}
