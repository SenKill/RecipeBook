//
//  HomeViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeViewController: CViewController<HomeView> {
    // Temperary data
    let recipes: [RecipeModel] = [
        RecipeModel(
            name: "Omelet",
            image: "omelet",
            author: "Food Network",
            isFavorite: false
        ),
        RecipeModel(
            name: "Bostom Creamy Pancakes",
            image: "pancake",
            author: "Delish",
            isFavorite: true
        ),
        RecipeModel(
            name: "Quick and Easy Breakfast",
            image: "breakfast",
            author: "Honest Cooking",
            isFavorite: false
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        customView.recipesCollectionView.delegate = self
        customView.recipesCollectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView.recipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipesCollectionViewCell.reuseId, for: indexPath)
        configureCell(cell, for: recipes[indexPath.row])
        return cell
    }
    
    func configureCell(_ cell: UICollectionViewCell, for recipe: RecipeModel) {
        
        guard let cell = cell as? RecipesCollectionViewCell else {
            print("ERROR: Failed to configure a cell")
            return
        }
        cell.mainImageView.image = UIImage(named: recipe.image)
        cell.recipeNameLabel.text = recipe.name
        cell.authorLabel.text = "by: " + recipe.author
        if recipe.isFavorite {
            cell.favoriteImageView.image = UIImage(systemName: "heart.fill")
            cell.favoriteImageView.tintColor = .red
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.recipesItemWidth, height: customView.recipesCollectionView.frame.height)
    }
}
