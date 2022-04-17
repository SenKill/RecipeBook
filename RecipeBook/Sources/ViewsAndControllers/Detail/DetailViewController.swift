//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func detailViewController(didToggleFavoriteWithIndex index: IndexPath, value: Bool, cell: RecipesCollectionViewCell?)
}

class DetailViewController: CViewController<DetailView> {
    enum IngredientsSizes {
        static let small = "100x100"
        static let medium = "250x250"
        static let big = "500x500"
    }
    
    weak var delegate: DetailViewControllerDelegate?
    weak var cell: RecipesCollectionViewCell?
    
    private var recipeData: Recipe!
    private var ingredients: [Ingredient] = []
    private var sourceUrl: URL?
    private var index: IndexPath!
    
    init(with recipeData: Recipe, index: IndexPath) {
        self.recipeData = recipeData
        if let ingredients = recipeData.extendedIngredients {
            self.ingredients = ingredients
        }
        self.index = index
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = DetailView(with: recipeData.nutrition)
        configureViewWithData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipeImage(with: recipeData.image)
        customView.delegate = self
        customView.ingredientsCollectionView.delegate = self
        customView.ingredientsCollectionView.dataSource = self
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
        dismiss(animated: true)
    }
    
    func detailView(didTapFavoriteButton button: FavoriteButton) {
        let localService = LocalService()
        let isCurrentlyFavorite: Bool = button.tintColor == UIColor.systemRed
        if isCurrentlyFavorite {
            localService.removeObjectFromFavorites(with: recipeData.id)
            customView.favoriteButton.setInactive()
        } else {
            localService.addToFavorites(recipeData)
            customView.favoriteButton.setActive()
        }
        delegate?.detailViewController(didToggleFavoriteWithIndex: index, value: !isCurrentlyFavorite, cell: cell)
    }
    
    func detailView(didTapInstructionsButton button: UIButton) {
        if let url = sourceUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
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

// MARK: - UICollectionViewDelegateFlowLayout
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
    
    // MARK: - Populating View With Data
    func configureViewWithData() {
        if recipeData.isFavorite ?? false {
            customView.favoriteButton.setActive()
        }
        
        customView.titleLabel.text = recipeData.title
        customView.sourceLabel.text = "by: \(recipeData.sourceName ?? "uknown")"
        customView.prepTimeLabel.text = "\(recipeData.readyInMinutes) Min"
        
        populateTags(with: recipeData)
        populateIngredientInfo(with: recipeData.extendedIngredients)
        populatePreparationInfo(with: recipeData.analyzedInstructions)
    }
    
    func populateTags(with recipe: Recipe) {
        let cuisineTags = recipe.cuisines
        let dishTags = recipe.dishTypes
        let dietTags = recipe.diets
        let occasionTags = recipe.occasions
        
        customView.tagsListView.addTags(cuisineTags + dishTags + dietTags + occasionTags)
        customView.tagsListView.tagViews.forEach { tagView in
            guard let tagTitle = tagView.titleLabel?.text else {
                return
            }
            tagView.setTitle(tagTitle.firstCapitalized, for: .normal)
            if cuisineTags.contains(tagTitle) {
                tagView.textColor = .systemOrange
            }
            if dietTags.contains(tagTitle) {
                tagView.textColor = .systemGreen
            }
            if occasionTags.contains(tagTitle) {
                tagView.textColor = .systemPurple
            }
            tagView.cornerRadius = 5
        }
    }
    
    func populateIngredientInfo(with ingredients: [Ingredient]?) {
        guard let ingredients = ingredients else { return }
        var finalString = ""
        for ingr in ingredients {
            if let textInfo = ingr.original {
                finalString += " • \(textInfo)\n"
            }
        }
        customView.ingredientsInfoLabel.text = finalString
    }
    
    func populatePreparationInfo(with instructions: [Instruction]) {
        let funny: Bool = false
        guard !funny else {
            if let url = URL(string: "https://youtu.be/dQw4w9WgXcQ") {
                sourceUrl = url
                customView.buildLinkButton()
            }
            return
        }
        
        guard let instruction = instructions.first,
              instruction.steps.capacity != 1
        else {
            if let url = URL(string: recipeData.sourceUrl) {
                sourceUrl = url
                customView.buildLinkButton()
            }
            return
        }
        var finalString = ""
        for step in instruction.steps {
            finalString += "\(step.number). \(step.step)\n\n"
        }
        customView.buildInstructions(with: finalString)
    }
}
