//
//  IngredientsCollectionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/27/22.
//

import Foundation
import UIKit

class IngredientsCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.ingrMinimumLineSpacing
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.reuseId)
        backgroundColor = .none
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "IngredientsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.theme.primaryText
        label.textAlignment = .center
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setViews() {
        addSubview(imageView)
        addSubview(nameLabel)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}

extension IngredientsCollectionViewCell {
    func configureCell(for ingredientName: String?, with image: UIImage?) {
        imageView.image = image
        nameLabel.text = ingredientName
    }
}
