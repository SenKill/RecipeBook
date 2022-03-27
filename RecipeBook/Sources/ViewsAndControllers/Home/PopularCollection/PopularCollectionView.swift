//
//  PopularCollectionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/17/22.
//

import UIKit

class PopularCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.popularMinimumLineSpacing
        
        contentInset = UIEdgeInsets(
            top: 0,
            left: Constants.leftDistance,
            bottom: 0,
            right: Constants.rightDistance)
        backgroundColor = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        clipsToBounds = false
        isScrollEnabled = false
        
        register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
