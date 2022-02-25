//
//  PopularViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/25/22.
//

import UIKit


class PopularViewController: UIViewController {
    var recipes: [RecipeModel] = []
}

// MARK: - UICollectionViewDelegate
extension PopularViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseId, for: indexPath)
        
        guard let popularCell = cell as? PopularCollectionViewCell else {
            print("ERROR: Cannot convert cell to PopularCollectionCell")
            return cell
        }
        
        popularCell.configureCell(for: recipes[indexPath.row])
        return popularCell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.popularItemWidth, height: Constants.popularItemHeight)
    }
}
