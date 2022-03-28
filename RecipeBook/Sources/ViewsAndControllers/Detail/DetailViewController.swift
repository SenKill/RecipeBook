//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

class DetailViewController: CViewController<DetailView> {
    enum ImageSizes {
        static let small = "100x100"
        static let medium = "250x250"
        static let big = "500x500"
    }
    
    var recipeData: Recipe!
    var ingredients: [Ingredient] = []
    
    init(recipeData: Recipe) {
        self.recipeData = recipeData
        if let ingredients = recipeData.extendedIngredients {
            self.ingredients = ingredients
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = DetailView(data: recipeData)
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        customView.ingredientsCollectionView.delegate = self
        customView.ingredientsCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.reuseId, for: indexPath) as! IngredientsCollectionViewCell
        
        let ingredient = ingredients[indexPath.row]
        // Setting just label text
        cell.configureCell(for: ingredient.name, with: nil)
        
        if let imageName = ingredient.image {
            NetworkService.fetchImage(for: .ingredient, with: imageName, size: ImageSizes.small) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        cell.configureCell(for: ingredient.name, with: UIImage(data: imageData))
                    case .failure(let error):
                        let alert = UIAlertController.errorAlert(message: error.localizedDescription)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 70)
    }
}
