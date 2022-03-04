//
//  PopularViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/25/22.
//

import UIKit

class PopularViewController: UIViewController {
    var recipes: [Recipe] = []
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
        let recipe = recipes[indexPath.row]
        
        popularCell.configureCell(for: recipe, with: nil)
        
        if let imageName = recipe.image {
            NetworkService.fetchImage(for: .recipe, from: imageName, size: nil) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        popularCell.configureCell(for: recipe, with: UIImage(data: data))
                    }
                case .failure(let error):
                    print("Fetching image error: \(error.localizedDescription)")
                }
            }
        }
        
        return popularCell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.popularItemWidth, height: Constants.popularItemHeight)
    }
}
