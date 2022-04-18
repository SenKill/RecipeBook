//
//  DetailView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit
import TagListView

protocol DetailViewDelegate: AnyObject {
    func detailView(didTapBackButton button: UIButton)
    func detailView(didTapFavoriteButton button: FavoriteButton)
    func detailView(didTapInstructionsButton button: UIButton)
}

class DetailView: CView {
    
    init(with nutrition: Nutrition?) {
        if let nutrition = nutrition {
            nutritionCombinedView = NutritionCombinedView(nutrition: nutrition)
        }
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    weak var delegate: DetailViewDelegate?
    
    private var isRecipeNutrition: Bool = false
    
    let backgroundDimmedLayer: CALayer = {
        let dimmedLayer = CALayer()
        dimmedLayer.backgroundColor = UIColor.black.cgColor
        dimmedLayer.opacity = 0.1
        return dimmedLayer
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrow.left", withConfiguration: iconConfiguration)
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let favoriteButton: FavoriteButton = {
        let button = FavoriteButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let prepTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Min"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let prepTimeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "alarm"))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tagsListView: TagListView = {
        let tagList = TagListView()
        tagList.textColor = .secondaryLabel
        tagList.tagBackgroundColor = .secondaryLabel.withAlphaComponent(0.15)
        tagList.textFont = UIFont.preferredFont(forTextStyle: .subheadline)
        
        tagList.paddingY = 7
        tagList.paddingX = 11
        tagList.alignment = .leading
        
        tagList.translatesAutoresizingMaskIntoConstraints = false
        return tagList
    }()
    
    let nutritionLabel: UILabel = {
        createTitleLabel(with: "Nutrition")
    }()
    
    private let nutritionDivider: UIView = {
        createDivider()
    }()
    
    var nutritionCombinedView: NutritionCombinedView?
    
    private let ingredientsLabel: UILabel = {
        createTitleLabel(with: "Ingredients")
    }()
    
    private let ingredientsDivider: UIView = {
        createDivider()
    }()
    
    let ingredientsCollectionView = IngredientsCollectionView()
    
    let ingredientsInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prepLabel: UILabel = {
        createTitleLabel(with: "Preparation")
    }()
    
    private let prepDivider: UIView = {
        createDivider()
    }()
    
    override func setViews() {
        super.setViews()
        backgroundImageView.layer.addSublayer(backgroundDimmedLayer)
        addSubview(backgroundImageView)
        addSubview(backButton)
        addSubview(favoriteButton)
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
        
        contentView.addSubview(prepLabel)
        contentView.addSubview(prepDivider)
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        
        contentView.clipsToBounds = false
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
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
            
            prepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            prepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            prepLabel.topAnchor.constraint(equalTo: ingredientsInfoLabel.bottomAnchor, constant: 25),
            
            prepDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            prepDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance),
            prepDivider.topAnchor.constraint(equalTo: prepLabel.bottomAnchor, constant: 10),
        ])
    }
}

// MARK: External
extension DetailView {
    func buildLinkButton() {
        let linkButton = UIButton()
        linkButton.backgroundColor = .systemGreen
        linkButton.setTitle("Instructions", for: .normal)
        linkButton.setTitleColor(.white, for: .normal)
        linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        linkButton.layer.cornerRadius = 10
        linkButton.layer.shadowColor = UIColor.black.cgColor
        linkButton.layer.shadowOpacity = 0.33
        linkButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        linkButton.layer.shadowRadius = 4
        
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(linkButton)
        
        linkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance).isActive = true
        linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance).isActive = true
        linkButton.topAnchor.constraint(equalTo: prepDivider.bottomAnchor, constant: 15).isActive = true
        linkButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        linkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        linkButton.addTarget(self, action: #selector(didTapInsturctionsButton(_:)), for: .touchUpInside)
    }
    
    func buildInstructions(with text: String) {
        let prepInfoLabel = UILabel()
        prepInfoLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        prepInfoLabel.textColor = .label
        prepInfoLabel.numberOfLines = 0
        prepInfoLabel.text = text
        prepInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(prepInfoLabel)
        
        prepInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance).isActive = true
        prepInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.rightDistance).isActive = true
        prepInfoLabel.topAnchor.constraint(equalTo: prepDivider.bottomAnchor, constant: 15).isActive = true
        prepInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

// MARK: Internal
private extension DetailView {
    static func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
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
    
    @objc func didTapBackButton(_ button: UIButton) {
        delegate?.detailView(didTapBackButton: button)
    }
    
    @objc func didTapFavoriteButton(_ button: FavoriteButton) {
        delegate?.detailView(didTapFavoriteButton: button)
    }
    
    @objc func didTapInsturctionsButton(_ button: UIButton) {
        delegate?.detailView(didTapInstructionsButton: button)
    }
}
