//
//  RecipesCollectionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class MealCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.reuseId)
        backgroundColor = .none
        layout.minimumLineSpacing = Constants.mealMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
