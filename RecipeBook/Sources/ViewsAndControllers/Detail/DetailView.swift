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
            isRecipeNutrition = true
            caloriesView = NutritionView(icon: UIImage(systemName: "flame")!, text: nutrition.calories)
            fatsView = NutritionView(icon: UIImage(systemName: "flame")!, text: nutrition.fats)
            carbsView = NutritionView(icon: UIImage(systemName: "flame")!, text: nutrition.carbohydrates)
            proteinView = NutritionView(icon: UIImage(systemName: "flame")!, text: nutrition.protein)
        }
        
        super.init(frame: .zero)
        configureViewsWithData(recipe)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var isRecipeNutrition: Bool = false
    
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
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.theme.primaryText
        label.text = "Nutrition"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nutritionDivider: UIView = {
        createDivier(with: UIColor.systemGray2.withAlphaComponent(0.5))
    }()
    
    private var caloriesView: NutritionView? = nil
    private var fatsView: NutritionView? = nil
    private var carbsView: NutritionView? = nil
    private var proteinView: NutritionView? = nil
    
    override func setViews() {
        super.setViews()
        addSubview(prepTimeLabel)
        addSubview(prepTimeIcon)
        addSubview(titleLabel)
        addSubview(sourceLabel)
        addSubview(tagsListView)
        addSubview(nutritionLabel)
        addSubview(nutritionDivider)
        
        if isRecipeNutrition {
            addSubview(caloriesView!)
            addSubview(fatsView!)
            addSubview(carbsView!)
            addSubview(proteinView!)
        }
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            prepTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            prepTimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            prepTimeIcon.trailingAnchor.constraint(equalTo: prepTimeLabel.leadingAnchor, constant: -5),
            prepTimeIcon.centerYAnchor.constraint(equalTo: prepTimeLabel.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            titleLabel.trailingAnchor.constraint(equalTo: prepTimeIcon.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            tagsListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            tagsListView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            tagsListView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 15),
            
            nutritionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            nutritionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            nutritionLabel.topAnchor.constraint(equalTo: tagsListView.bottomAnchor, constant: 15),
            
            nutritionDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            nutritionDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            nutritionDivider.topAnchor.constraint(equalTo: nutritionLabel.bottomAnchor, constant: 10)
        ])
        
        if isRecipeNutrition {
            NSLayoutConstraint.activate([
                caloriesView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
                caloriesView!.topAnchor.constraint(equalTo: nutritionDivider.bottomAnchor, constant: 15),
                caloriesView!.trailingAnchor.constraint(equalTo: proteinView!.leadingAnchor),
                
                carbsView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
                carbsView!.topAnchor.constraint(equalTo: caloriesView!.bottomAnchor, constant: 10),
                carbsView!.trailingAnchor.constraint(equalTo: fatsView!.leadingAnchor),
                
                // TODO: Create NutritionView that can be both left and right aligned
                proteinView!.topAnchor.constraint(equalTo: nutritionDivider.bottomAnchor, constant: 15),
                proteinView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
                proteinView!.widthAnchor.constraint(equalTo: caloriesView!.widthAnchor, constant: -100),
                
                fatsView!.topAnchor.constraint(equalTo: proteinView!.bottomAnchor, constant: 10),
                fatsView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
                fatsView!.widthAnchor.constraint(equalTo: carbsView!.widthAnchor, constant: -100)
            ])
        }
    }
}

private extension DetailView {
    func configureViewsWithData(_ recipe: Recipe) {
        titleLabel.text = recipe.title
        sourceLabel.text = "by: \(recipe.sourceName ?? "undefined")"
        prepTimeLabel.text = "\(recipe.readyInMinutes) Min"
        
        let cuisineTags = recipe.cuisines
        let dishTags = recipe.dishTypes
        let dietTags = recipe.diets
        let occasionTags = recipe.occasions
        
        tagsListView.addTags(cuisineTags + dishTags + dietTags + occasionTags)
        tagsListView.tagViews.forEach { tagView in
            guard let tagTitle = tagView.titleLabel?.text else {
                return
            }
            
            if dietTags.contains(tagTitle) {
                tagView.textColor = .systemGreen
            }
            tagView.cornerRadius = 5
        }
    }
    
    static func createDivier(with color: UIColor) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return divider
    }
}
