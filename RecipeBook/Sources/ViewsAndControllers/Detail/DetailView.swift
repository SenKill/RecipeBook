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
        createDivider(with: UIColor.systemGray2.withAlphaComponent(0.5))
    }()
    
    private let ingerientsLabel: UILabel = {
        createTitleLabel(with: "Ingredients")
    }()
    
    private var nutritionCombinedView: NutritionCombinedView?
    
    override func setViews() {
        super.setViews()
        addSubview(prepTimeLabel)
        addSubview(prepTimeIcon)
        addSubview(titleLabel)
        addSubview(sourceLabel)
        addSubview(tagsListView)
        
        if let nutritionView = nutritionCombinedView {
            addSubview(nutritionLabel)
            addSubview(nutritionDivider)
            addSubview(nutritionView)
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
        ])
        
        if let nutritionView = nutritionCombinedView {
            nutritionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nutritionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
                nutritionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
                nutritionLabel.topAnchor.constraint(equalTo: tagsListView.bottomAnchor, constant: 15),
                
                nutritionDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
                nutritionDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
                nutritionDivider.topAnchor.constraint(equalTo: nutritionLabel.bottomAnchor, constant: 10),
                
                nutritionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
                nutritionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
                nutritionView.topAnchor.constraint(equalTo: nutritionDivider.bottomAnchor, constant: 15)
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
    
    static func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.theme.primaryText
        label.text = "Nutrition"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createDivider(with color: UIColor) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return divider
    }
}
