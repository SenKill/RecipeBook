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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(mainImageView)
        addSubview(recipeNameLabel)
        addSubview(authorNameLabel)
        addSubview(prepTimeImageView)
        addSubview(prepTimeLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            mainImageView.leftAnchor.constraint(equalTo: leftAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            
            authorNameLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10),
            authorNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            authorNameLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            
            recipeNameLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10),
            recipeNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            recipeNameLabel.bottomAnchor.constraint(equalTo: authorNameLabel.topAnchor, constant: -15),
            
            prepTimeImageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10),
            prepTimeImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 15),
            prepTimeImageView.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1/5),
            prepTimeImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1/5),
            
            prepTimeLabel.leftAnchor.constraint(equalTo: prepTimeImageView.rightAnchor, constant: 5),
            prepTimeLabel.topAnchor.constraint(equalTo: prepTimeImageView.topAnchor),
            prepTimeLabel.bottomAnchor.constraint(equalTo: prepTimeImageView.bottomAnchor),
        ])
    }
}
