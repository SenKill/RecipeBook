//
//  HomeView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeView: CView {
    let mealCollectionView = MealCollectionView()
    let popularCollectionView = PopularCollectionView()
    
    // TODO: Change label's text
    private let firstWelcomingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning!🌅"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondWelcomingLabel: UILabel = {
       let label = UILabel()
        label.text = "What are you going to cook today?"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mealLabel: UILabel = {
        let label = UILabel()
        label.text = "Breakfast"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundView: UIView = {
        let gradientView: UIView = GradientView(startColor: UIColor.theme.gradientBackgroundFirst, endColor: UIColor.theme.gradientBackgroundSecond)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    private let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        backgroundColor = UIColor.theme.background
        
        addSubview(backgroundView)
        addSubview(firstWelcomingLabel)
        addSubview(secondWelcomingLabel)
        addSubview(mealLabel)
        addSubview(mealCollectionView)
        addSubview(popularLabel)
        addSubview(popularCollectionView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        mealCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/10),
            
            firstWelcomingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            firstWelcomingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leftDistance),
            firstWelcomingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            secondWelcomingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            secondWelcomingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leftDistance),
            secondWelcomingLabel.topAnchor.constraint(equalTo: firstWelcomingLabel.bottomAnchor, constant: 10),
            
            mealLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            mealLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leftDistance),
            mealLabel.topAnchor.constraint(equalTo: secondWelcomingLabel.bottomAnchor, constant: 20),
            
            mealCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mealCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mealCollectionView.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: 15),
            mealCollectionView.heightAnchor.constraint(equalToConstant: Constants.mealCollectionHeight),
            
            popularLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            popularLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.rightDistance),
            popularLabel.topAnchor.constraint(equalTo: mealCollectionView.bottomAnchor, constant: 30),
            
            popularCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 15),
            popularCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
