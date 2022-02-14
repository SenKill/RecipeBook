//
//  HomeView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeView: CView {
    let recipesCollectionView = RecipesCollectionView()
    
    // TODO: Change label's text
    private let firstWelcomingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning!🌅"
        label.font = UIFont(name: "Avenir-Light", size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondWelcomingLabel: UILabel = {
       let label = UILabel()
        label.text = "What are you going to cook today?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        backgroundColor = UIColor.theme.background
        
        addSubview(firstWelcomingLabel)
        addSubview(secondWelcomingLabel)
        addSubview(recipesCollectionView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        recipesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstWelcomingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            firstWelcomingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leftDistance),
            firstWelcomingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            secondWelcomingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            secondWelcomingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leftDistance),
            secondWelcomingLabel.topAnchor.constraint(equalTo: firstWelcomingLabel.bottomAnchor, constant: 10),
            
            recipesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipesCollectionView.topAnchor.constraint(equalTo: secondWelcomingLabel.bottomAnchor, constant: 50),
            recipesCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
