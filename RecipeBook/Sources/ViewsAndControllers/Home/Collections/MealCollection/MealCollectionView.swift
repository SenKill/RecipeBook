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
        layout.minimumLineSpacing = Constants.mealMinimumLineSpacing
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.reuseId)
        backgroundColor = .none
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
