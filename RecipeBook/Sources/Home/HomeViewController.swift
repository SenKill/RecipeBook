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
    let mealSampleRecipes: [RecipeModel] = [
        RecipeModel(
            name: "Omelet",
            image: "omelet",
            author: "Food Network",
            prepTime: 20,
            isFavorite: false
        ),
        RecipeModel(
            name: "Bostom Creamy Pancakes",
            image: "pancake",
            author: "Delish",
            prepTime: 20,
            isFavorite: true
        ),
        RecipeModel(
            name: "Quick and Easy Breakfast",
            image: "breakfast",
            author: "Honest Cooking",
            prepTime: 20,
            isFavorite: false
        )
    ]
    
    let popularSampleRecipes: [RecipeModel] = [
        RecipeModel(
            name: "Best Ever Bolognese Sauce",
            image: "1",
            author: "Foodista",
            prepTime: 45,
            isFavorite: false
        ),
        
        RecipeModel(
            name: "Mint Chocolate Chip Ice Cream",
            image: "2",
            author: "Foodista",
            prepTime: 45,
            isFavorite: false
        ),
        
        RecipeModel(
            name: "Chicken with Grape Tomatoes and Mushrooms",
            image: "3",
            author: "Foodista",
            prepTime: 45,
            isFavorite: false
        ),
        
        RecipeModel(
            name: "Dreamy Chai Rice Pudding",
            image: "4",
            author: "Foodista",
            prepTime: 45,
            isFavorite: false
        ),
        
        RecipeModel(
            name: "Triple Citrus Cake",
            image: "5",
            author: "Foodista",
            prepTime: 45,
            isFavorite: false
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        customView.mealCollectionView.delegate = self
        customView.mealCollectionView.dataSource = self
        
        customView.popularCollectionView.delegate = self
        customView.popularCollectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == customView.mealCollectionView {
            return mealSampleRecipes.count
        } else {
            return popularSampleRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if collectionView == customView.mealCollectionView {
            cell = customView.mealCollectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseId, for: indexPath)
            configureMealCell(cell, for: mealSampleRecipes[indexPath.row])
        } else {
            cell = customView.popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseId, for: indexPath)
            configurePopularCell(cell, for: popularSampleRecipes[indexPath.row])
        }
        
        return cell
    }
    
    func configureMealCell(_ cell: UICollectionViewCell, for recipe: RecipeModel) {
        
        guard let cell = cell as? MealCollectionViewCell else {
            print("ERROR: Failed to configure a cell")
            return
        }
        
        cell.mainImageView.image = UIImage(named: recipe.image)
        cell.recipeNameLabel.text = recipe.name
        cell.authorNameLabel.text = "by: " + recipe.author
        if recipe.isFavorite {
            cell.favoriteImageView.image = UIImage(systemName: "heart.fill")
            cell.favoriteImageView.tintColor = .red
        }
    }
    
    func configurePopularCell(_ cell: UICollectionViewCell, for recipe: RecipeModel) {
        
        guard let cell = cell as? PopularCollectionViewCell else {
            print("ERROR: Failed to configure a cell")
            return
        }
        
        cell.mainImageView.image = UIImage(named: recipe.image)
        cell.recipeNameLabel.text = recipe.name
        cell.authorNameLabel.text = "by: " + recipe.author
        cell.prepTimeLabel.text = "\(recipe.prepTime) Min"
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == customView.mealCollectionView {
            return CGSize(width: Constants.mealItemWidth, height: customView.mealCollectionView.frame.height)
        } else {
            print("Chel")
            return CGSize(width: Constants.popularItemWidth, height: Constants.popularItemHeight)
        }
    }
}
