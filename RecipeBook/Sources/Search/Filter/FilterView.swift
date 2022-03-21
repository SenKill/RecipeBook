//
//  FilterView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/16/22.
//

import Foundation
import UIKit

class FilterView: CView {
    private let cuisineLabel: UILabel = {
        createLabel(with: "Select Cuisine")
    }()
    
    let cuisineFieldContainer: UIView = {
        createTextField(with: "Choose cuisine...", rightView: "chevron.down")
    }()
    
    private let dietsLabel: UILabel = {
        createLabel(with: "Diets")
    }()
    
    let dietsFieldContainer: UIView = {
        createTextField(with: "You can add multiple diets..", rightView: "plus.circle")
    }()
    
    private let intolerancesLabel: UILabel = {
        createLabel(with: "Intolerances")
    }()
    
    let intolerancesContainer: UIView = {
        createTextField(with: "Add intolerances here...", rightView: "plus.circle")
    }()
    
    let pickerView = UIPickerView()
    
    override func setViews() {
        super.setViews()
        addSubview(cuisineLabel)
        addSubview(cuisineFieldContainer)
        addSubview(dietsLabel)
        addSubview(dietsFieldContainer)
        addSubview(intolerancesLabel)
        addSubview(intolerancesContainer)
        if let textField = cuisineFieldContainer.subviews.first as? UITextField {
            textField.inputView = pickerView
        }
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            cuisineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cuisineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cuisineLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            cuisineFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cuisineFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cuisineFieldContainer.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 10),
            cuisineFieldContainer.heightAnchor.constraint(equalToConstant: 55),
            
            dietsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dietsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dietsLabel.topAnchor.constraint(equalTo: cuisineFieldContainer.bottomAnchor, constant: 20),
            
            dietsFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dietsFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dietsFieldContainer.topAnchor.constraint(equalTo: dietsLabel.bottomAnchor, constant: 10),
            dietsFieldContainer.heightAnchor.constraint(equalToConstant: 50),
            
            intolerancesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            intolerancesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            intolerancesLabel.topAnchor.constraint(equalTo: dietsFieldContainer.bottomAnchor, constant: 20),
            
            intolerancesContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            intolerancesContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            intolerancesContainer.topAnchor.constraint(equalTo: intolerancesLabel.bottomAnchor, constant: 10),
            intolerancesContainer.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}

// Private support functions
private extension FilterView {
    // Created to avoid code duplication
    static func createTextField(with placeholder: String?, rightView: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = UITextField()
        textField.rightView = UIImageView(image: UIImage(systemName: rightView))
        textField.rightViewMode = .always
        textField.placeholder = placeholder
        textField.rightView?.tintColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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
