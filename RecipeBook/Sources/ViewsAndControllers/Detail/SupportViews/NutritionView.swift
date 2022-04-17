//
//  NutritionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/26/22.
//

import Foundation
import UIKit

class NutritionCombinedView: UIView {
    private var caloriesView: NutritionView!
    private var fatsView: NutritionView!
    private var carbsView: NutritionView!
    private var proteinView: NutritionView!
    
    init(nutrition: Nutrition) {
        caloriesView = NutritionView(icon: UIImage.images.calories, text: nutrition.calories, textAlignment: .left)
        carbsView = NutritionView(icon: UIImage.images.carbs, text: nutrition.carbohydrates, textAlignment: .left)
        proteinView = NutritionView(icon: UIImage.images.protein, text: nutrition.protein, textAlignment: .right)
        fatsView = NutritionView(icon: UIImage.images.fats, text: nutrition.fats, textAlignment: .right)
        super.init(frame: .zero)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        addSubview(caloriesView)
        addSubview(fatsView)
        addSubview(carbsView)
        addSubview(proteinView)
    }
    
    func layoutViews() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caloriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            caloriesView.topAnchor.constraint(equalTo: topAnchor),
            
            carbsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carbsView.topAnchor.constraint(equalTo: caloriesView.bottomAnchor, constant: 10),
            
            proteinView.topAnchor.constraint(equalTo: topAnchor),
            proteinView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            fatsView.topAnchor.constraint(equalTo: proteinView.bottomAnchor, constant: 10),
            fatsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomAnchor.constraint(equalTo: carbsView.bottomAnchor)
        ])
    }
}

class NutritionView: UIView {
    private var textAlignment: NSTextAlignment!
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(icon: UIImage, text: String, textAlignment: NSTextAlignment) {
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        populateView(icon: icon, text: text)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        addSubview(label)
        backgroundView.addSubview(iconView)
        addSubview(backgroundView)
    }
    
    func layoutViews() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Need for constraining left or right nutrition column
        switch textAlignment {
        case .left:
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor),
                
                label.leadingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 5),
                label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
        case .right:
            NSLayoutConstraint.activate([
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.widthAnchor.constraint(equalToConstant: 100),
                
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -5),
                backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor),
                
                label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            ])
        default:
            return
        }
        
        iconView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        iconView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }
    
    private func populateView(icon: UIImage, text: String) {
        iconView.image = icon
        label.text = text
    }
}
