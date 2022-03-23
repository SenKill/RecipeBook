//
//  FilterView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/16/22.
//

import Foundation
import UIKit
import TagListView

class FilterView: CView {
    private let cuisineLabel: UILabel = {
        createLabel(with: "Select Cuisine")
    }()
    
    let cuisineFieldContainer: UIView = {
        createTextField(with: "Select cuisine", rightView: "chevron.down", editable: false)
    }()
    
    private let dietLabel: UILabel = {
        createLabel(with: "Diet")
    }()
    
    let dietFieldContainer: UIView = {
        createTextField(with: "Select diet", rightView: "chevron.down", editable: false)
    }()
    
    private let intolerancesLabel: UILabel = {
        createLabel(with: "Intolerances")
    }()
    
    let intolerancesView: TagListView = {
        let tagList = TagListView()
        // Change properties here
        tagList.textFont = UIFont.preferredFont(forTextStyle: .body)
        
        tagList.tagBackgroundColor = UIColor.theme.tagViewBackground
        tagList.tagSelectedBackgroundColor = UIColor.theme.tagViewBackgroundSelected
        tagList.textColor = UIColor.systemGray
        tagList.selectedTextColor = UIColor.theme.primaryText
        
        tagList.paddingX = 8
        tagList.paddingY = 8
        tagList.alignment = .leading
        
        tagList.addTags(["Dairy","Egg","Gluten","Grain","Peanut",
                         "Seafood","Sesame","Shellfish","Soy",
                         "Sulfite","Tree Nut","Wheat"])
        
        for tag in tagList.tagViews {
            tag.layer.cornerRadius = 5
        }
        tagList.translatesAutoresizingMaskIntoConstraints = false
        return tagList
    }()
    
    let cuisinePicker = UIPickerView()
    let dietPicker = UIPickerView()
    
    private let caloriesLabel: UILabel = {
        createLabel(with: "Calories")
    }()
    
    let caloriesSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 2500
        slider.tintColor = .systemGreen
        slider.minimumValueImage = UIImage(systemName: "flame")
        slider.maximumValueImage = UIImage(systemName: "flame.fill")
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let leftCaloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightCaloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "2500"
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentCalories: UILabel = {
        let label = UILabel()
        label.text = "Max calories: 0"
        label.textColor = UIColor.theme.primaryText
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        addSubview(cuisineLabel)
        addSubview(cuisineFieldContainer)
        addSubview(dietLabel)
        addSubview(dietFieldContainer)
        addSubview(intolerancesLabel)
        addSubview(intolerancesView)
        addSubview(caloriesLabel)
        addSubview(caloriesSlider)
        addSubview(leftCaloriesLabel)
        addSubview(rightCaloriesLabel)
        addSubview(currentCalories)
        
        if let cuisineTextField = cuisineFieldContainer.subviews.first as? FilterTextField,
           let dietTextField = dietFieldContainer.subviews.first as? FilterTextField {
            cuisineTextField.inputView = cuisinePicker
            dietTextField.inputView = dietPicker
        }
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            cuisineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cuisineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cuisineLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            
            cuisineFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cuisineFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cuisineFieldContainer.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 10),
            cuisineFieldContainer.heightAnchor.constraint(equalToConstant: 55),
            
            dietLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dietLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dietLabel.topAnchor.constraint(equalTo: cuisineFieldContainer.bottomAnchor, constant: 25),
            
            dietFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dietFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dietFieldContainer.topAnchor.constraint(equalTo: dietLabel.bottomAnchor, constant: 10),
            dietFieldContainer.heightAnchor.constraint(equalToConstant: 50),
            
            intolerancesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            intolerancesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            intolerancesLabel.topAnchor.constraint(equalTo: dietFieldContainer.bottomAnchor, constant: 25),
            
            intolerancesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            intolerancesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            intolerancesView.topAnchor.constraint(equalTo: intolerancesLabel.bottomAnchor, constant: 10),
            
            caloriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            caloriesLabel.topAnchor.constraint(equalTo: intolerancesView.bottomAnchor, constant: 25),
            
            caloriesSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            caloriesSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            caloriesSlider.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10),
            
            leftCaloriesLabel.leadingAnchor.constraint(equalTo: caloriesSlider.leadingAnchor),
            leftCaloriesLabel.topAnchor.constraint(equalTo: caloriesSlider.bottomAnchor, constant: 3),
            
            rightCaloriesLabel.trailingAnchor.constraint(equalTo: caloriesSlider.trailingAnchor),
            rightCaloriesLabel.topAnchor.constraint(equalTo: caloriesSlider.bottomAnchor, constant: 3),
            
            currentCalories.trailingAnchor.constraint(equalTo: caloriesSlider.trailingAnchor),
            currentCalories.bottomAnchor.constraint(equalTo: caloriesSlider.topAnchor, constant: -3)
        ])
    }
}

// Private support functions
private extension FilterView {
    // Created to avoid code duplication
    static func createTextField(with placeholder: String?, rightView: String, editable: Bool) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = editable ? UITextField() : FilterTextField()
        textField.rightView = UIImageView(image: UIImage(systemName: rightView))
        textField.rightViewMode = .always
        textField.placeholder = placeholder
        textField.rightView?.tintColor = UIColor.theme.primaryText
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.theme.primaryText
        
        container.addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive = true
        textField.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        textField.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5).isActive = true
        
        return container
    }
    
    static func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
