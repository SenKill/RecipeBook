//
//  PopularCollectionViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/17/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PopularCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorNameLabel: UILabel = {
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
    
    let prepTimeLabel: UILabel = {
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
    
    let servingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bookmarkImageView: UIImageView = {
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
    
    func setViews() {
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
    
    func layoutViews() {
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
}
