//
//  DetailView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit
import TagListView

class DetailView: CView {
    
    init(data recipe: Recipe) {
        if let nutrition = recipe.nutrition {
            nutritionCombinedView = NutritionCombinedView(nutrition: nutrition)
        }
        super.init(frame: .zero)
        configureViewsWithData(recipe)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var isRecipeNutrition: Bool = false
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.theme.background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor.theme.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prepTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Min"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prepTimeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "alarm"))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tagsListView: TagListView = {
        let tagList = TagListView()
        tagList.textColor = .secondaryLabel
        tagList.tagBackgroundColor = UIColor.theme.secondaryText.withAlphaComponent(0.25)
        tagList.textFont = UIFont.preferredFont(forTextStyle: .subheadline)
        
        tagList.paddingY = 7
        tagList.paddingX = 11
        tagList.alignment = .leading
        
        tagList.translatesAutoresizingMaskIntoConstraints = false
        return tagList
    }()
    
    private let nutritionLabel: UILabel = {
        createTitleLabel(with: "Nutrition")
    }()
    
    private let nutritionDivider: UIView = {
        createDivider()
    }()
    
    private var nutritionCombinedView: NutritionCombinedView?
    
    private let ingredientsLabel: UILabel = {
        createTitleLabel(with: "Ingredients")
    }()
    
    private let ingredientsDivider: UIView = {
        createDivider()
    }()
    
    let ingredientsCollectionView = IngredientsCollectionView()
    
    private let ingredientsInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.theme.primaryText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        addSubview(backgroundImageView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(prepTimeLabel)
        contentView.addSubview(prepTimeIcon)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(tagsListView)
        if let nutritionView = nutritionCombinedView {
            contentView.addSubview(nutritionLabel)
            contentView.addSubview(nutritionDivider)
            contentView.addSubview(nutritionView)
        }
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsDivider)
        contentView.addSubview(ingredientsCollectionView)
        contentView.addSubview(ingredientsInfoLabel)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 250),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            
            prepTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            prepTimeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            prepTimeIcon.trailingAnchor.constraint(equalTo: prepTimeLabel.leadingAnchor, constant: -5),
            prepTimeIcon.centerYAnchor.constraint(equalTo: prepTimeLabel.centerYAnchor),
            
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            tagsListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            tagsListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            tagsListView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 15),
        ])
        
        var viewBottomAnchor = tagsListView.bottomAnchor
        if let nutritionView = nutritionCombinedView {
            NSLayoutConstraint.activate([
                nutritionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
                nutritionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
                nutritionLabel.topAnchor.constraint(equalTo: tagsListView.bottomAnchor, constant: 15),
                
                nutritionDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
                nutritionDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
                nutritionDivider.topAnchor.constraint(equalTo: nutritionLabel.bottomAnchor, constant: 10),
                
                nutritionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
                nutritionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
                nutritionView.topAnchor.constraint(equalTo: nutritionDivider.bottomAnchor, constant: 15),
            ])
            viewBottomAnchor = nutritionView.bottomAnchor
        }
        
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            ingredientsLabel.topAnchor.constraint(equalTo: viewBottomAnchor, constant: 25),
            
            ingredientsDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            ingredientsDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            ingredientsDivider.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
            
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsDivider.bottomAnchor, constant: 10),
            ingredientsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            ingredientsInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            ingredientsInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            ingredientsInfoLabel.topAnchor.constraint(equalTo: ingredientsCollectionView.bottomAnchor, constant: 10),
            ingredientsInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

private extension DetailView {
    func configureViewsWithData(_ recipe: Recipe) {
        titleLabel.text = recipe.title
        sourceLabel.text = "by: \(recipe.sourceName ?? "undefined")"
        prepTimeLabel.text = "\(recipe.readyInMinutes) Min"
        
        populateTags(with: recipe)
        populateIngredientInfo(with: recipe.extendedIngredients)
    }
    
    func populateTags(with recipe: Recipe) {
        let cuisineTags = recipe.cuisines
        let dishTags = recipe.dishTypes
        let dietTags = recipe.diets
        let occasionTags = recipe.occasions
        
        tagsListView.addTags(cuisineTags + dishTags + dietTags + occasionTags)
        tagsListView.tagViews.forEach { tagView in
            guard let tagTitle = tagView.titleLabel?.text else {
                return
            }
            tagView.setTitle(tagTitle.firstCapitalized, for: .normal)
            
            if dietTags.contains(tagTitle) {
                tagView.textColor = .systemGreen
            }
            tagView.cornerRadius = 5
        }
    }
    
    func populateIngredientInfo(with ingredients: [Ingredient]?) {
        guard let ingredients = ingredients else {
            return
        }
        
        var finalString = ""
        for ingr in ingredients {
            if let textInfo = ingr.original {
                finalString += " • \(textInfo)\n"
            }
        }
        ingredientsInfoLabel.text = finalString
    }
    
    static func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.theme.primaryText
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = UIColor.theme.divider
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return divider
    }
}
