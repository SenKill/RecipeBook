//
//  RecipesCollectionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import UIKit

class RecipesCollectionView: UICollectionView {

    var cells: [RecipeModel] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .green
        register(RecipesCollectionViewCell.self, forCellWithReuseIdentifier: RecipesCollectionViewCell.reuseId)
        
        
        layout.minimumLineSpacing = Constants.recipesMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells: [RecipeModel]) {
        self.cells = cells
    }
}
