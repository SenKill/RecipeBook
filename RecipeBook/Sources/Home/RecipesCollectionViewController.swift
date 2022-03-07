//
//  RecipesCollectionViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/5/22.
//

import UIKit

protocol ConfigurableCell where Self: UICollectionViewCell {
    func configureCell(for recipe: Recipe, with image: UIImage?)
}

class RecipesCollectionViewController: UIViewController {
    var recipes: [Recipe] = []
}


// MARK: - UICollectionViewDelegate
extension RecipesCollectionViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource
extension RecipesCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        // Giving newCell protocol type for using it's method configureCell()
        let newCell: ConfigurableCell!
        
        if collectionView.tag == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseId, for: indexPath)
            newCell = cell as! MealCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseId, for: indexPath)
            newCell = cell as! PopularCollectionViewCell
        }
        
        let recipe = recipes[indexPath.row]
        
        newCell.configureCell(for: recipe, with: nil)
        
        // Checking image property that stored in model, and fetching if it exists
        if let imageName = recipe.image {
            NetworkService.fetchImage(for: .recipe, from: imageName, size: nil) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        newCell.configureCell(for: recipe, with: UIImage(data: data))
                    }
                case .failure(let error):
                    if let error = error as? NetworkError {
                        print("Fetching image error: \(error.errorDescription)")
                    } else {
                        print("Fetching image error: \(error.localizedDescription)")
                    }
                }
            }
        }
        return newCell
    }
}
