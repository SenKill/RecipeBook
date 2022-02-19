//
//  HomeViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeViewController: CViewController<HomeView> {
    private var mealRecipes: [RecipeModel] = []
    private var popularRecipes: [RecipeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        
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
            return mealRecipes.count
        } else {
            return popularRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if collectionView == customView.mealCollectionView {
            cell = customView.mealCollectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseId, for: indexPath)
            configureMealCell(cell, for: mealRecipes[indexPath.row])
        } else {
            cell = customView.popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseId, for: indexPath)
            configurePopularCell(cell, for: popularRecipes[indexPath.row])
        }
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == customView.mealCollectionView {
            return CGSize(width: Constants.mealItemWidth, height: customView.mealCollectionView.frame.height)
        } else {
            return CGSize(width: Constants.popularItemWidth, height: Constants.popularItemHeight)
        }
    }
}


// MARK: - Internal

extension HomeViewController {
    
    func fetchData() {
        let data = RecipeData()
        self.mealRecipes = data.getMealRecipes()
        self.popularRecipes = data.getPopularRecipes()
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
            cell.bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
            cell.bookmarkImageView.tintColor = .systemGreen // or .systemYellow
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
        cell.servingsLabel.text = "\(recipe.servings) Servings"
    }
}
