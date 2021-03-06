//
//  RecipesCollectionViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/5/22.
//

import UIKit

class RecipesCollectionViewController: UIViewController {
    var recipes: [Recipe] = []
    private let localService = LocalService()
    private let networkService = NetworkService.shared
}

// MARK: - FavoriteButtonDelegate
extension RecipesCollectionViewController: FavoriteButtonDelegate {
    func didTapFavoriteButton(_ sender: FavoriteButton, index: IndexPath) {
        guard !recipes.isEmpty else { return }
        let recipe = recipes[index.row]
        if sender.tintColor == UIColor.systemRed {
            localService.removeObjectFromFavorites(with: recipe.id)
            recipes[index.row].isFavorite = false
            sender.setInactive()
        } else {
            localService.addToFavorites(recipe)
            recipes[index.row].isFavorite = true
            sender.setActive()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension RecipesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !recipes.isEmpty else {
            return
        }
        let detailVC = DetailViewController(with: recipes[indexPath.row], index: indexPath)
        detailVC.delegate = self
        detailVC.cell = collectionView.cellForItem(at: indexPath) as? RecipesCollectionViewCell
        present(detailVC, animated: true)
    }
}


// MARK: - DetailViewControllerDelegate
extension RecipesCollectionViewController: DetailViewControllerDelegate {
    func detailViewController(didToggleFavoriteWithIndex index: IndexPath, value: Bool, cell: RecipesCollectionViewCell?) {
        recipes[index.row].isFavorite = value
        guard let cell = cell else {
            print("Can't find cell that become favorite")
            return
        }
        if value {
            cell.favoriteButton.setActive()
        } else {
            cell.favoriteButton.setInactive()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return Constants.mealCount
        }
        return Constants.popularCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Giving to the cell protocol type for using it's method configureCell()
        var cell: RecipesCollectionViewCell!
        
        if collectionView.tag == 1,
           let mealCell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseId, for: indexPath) as? MealCollectionViewCell {
            mealCell.index = indexPath
            mealCell.delegate = self
            cell = mealCell
        } else if let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseId, for: indexPath) as? PopularCollectionViewCell {
            popularCell.index = indexPath
            popularCell.delegate = self
            cell = popularCell
        }
        
        guard recipes.count != 0 else {
            return cell
        }
        
        let recipe = recipes[indexPath.row]
        cell.configureCell(for: recipe, with: nil)
        
        // Checking image property that stored in model, and fetching if it exists
        if let imageName = recipe.image {
            networkService.fetchImage(for: .recipe, with: imageName, size: nil) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        cell.configureCell(for: recipe, with: UIImage(data: data))
                    }
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(title: "Loading image error", message: error.localizedDescription)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            cell.configureCell(for: recipe, with: UIImage.images.defaultRecipe)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: Constants.mealItemWidth, height: Constants.mealCollectionHeight)
        }
        return CGSize(width: Constants.popularItemWidth, height: Constants.popularItemHeight)
    }
}
