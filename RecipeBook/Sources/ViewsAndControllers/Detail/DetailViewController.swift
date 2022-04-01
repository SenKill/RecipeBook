//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

class DetailViewController: CViewController<DetailView> {
    enum IngredientsSizes {
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
        super.viewDidLoad()
        loadRecipeImage(with: recipeData.image)
        customView.delegate = self
        customView.ingredientsCollectionView.delegate = self
        customView.ingredientsCollectionView.dataSource = self
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let back = customView.backButton
        let favorite = customView.favoriteButton
        back.layer.cornerRadius = 0.5 * back.bounds.size.width
        favorite.layer.cornerRadius = 0.5 * favorite.bounds.size.width
    }
}

// MARK: - DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    func detailView(didTapBackButton button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func detailView(didTapFavoriteButton button: UIButton) {
        if button.tintColor != .systemRed {
            button.tintColor = .systemRed
        } else {
            button.tintColor = .white
        }
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
            NetworkService.fetchImage(for: .ingredient, with: imageName, size: IngredientsSizes.small) { result in
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

// MARK: - Internal
private extension DetailViewController {
    func loadRecipeImage(with name: String?) {
        guard let imageName = name else { return }
        
        NetworkService.fetchImage(for: .recipe, with: imageName.changeImageSize(to: ImageSizes.huge), size: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.customView.backgroundImageView.image = UIImage(data: data)
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(message: error.localizedDescription)
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
