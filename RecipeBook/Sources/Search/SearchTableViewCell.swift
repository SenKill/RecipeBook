//
//  SearchTableViewCell.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/27/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(mainImageView)
        addSubview(recipeNameLabel)
        addSubview(infoLabel)
        addSubview(authorLabel)
    }
    
    func layoutViews() {
        
        // TODO: Change constraints from constant to flexible
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            
            infoLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            
            recipeNameLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeNameLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -10),
            
            authorLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func configureCell(for recipe: RecipeModel) {
        // Set up content
    }
}
