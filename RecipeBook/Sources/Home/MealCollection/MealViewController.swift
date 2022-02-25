//
//  MealViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/25/22.
//

import UIKit


class MealViewController: UIViewController {
    var recipes: [RecipeModel] = []
}


// MARK: - UICollectionViewDelegate
extension MealViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource
extension MealViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseId, for: indexPath)
    
        guard let mealCell = cell as? MealCollectionViewCell else {
            print("ERROR: Cannot convert cell to MealCollectionViewCell")
            return cell
        }
        
        mealCell.configureCell(for: recipes[indexPath.row])
        return mealCell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension MealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.mealItemWidth, height: collectionView.frame.height)
    }
}
