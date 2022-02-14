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
        customView.recipesCollectionView.set(cells: recipes)
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
        let cell = customView.recipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipesCollectionViewCell.reuseId, for: indexPath) as! RecipesCollectionViewCell
        cell.mainImageView.image = UIImage(named: recipes[indexPath.row].image)
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.recipesItemWidth, height: customView.recipesCollectionView.frame.height)
    }
}
