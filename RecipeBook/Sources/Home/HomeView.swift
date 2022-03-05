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
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstWelcomingLabel: UILabel = {
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
    
    let mealLabel: UILabel = {
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
        
        mealCollectionView.tag = 1
        popularCollectionView.tag = 2
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(backgroundView)
        contentView.addSubview(firstWelcomingLabel)
        contentView.addSubview(secondWelcomingLabel)
        contentView.addSubview(mealLabel)
        contentView.addSubview(mealCollectionView)
        contentView.addSubview(popularLabel)
        contentView.addSubview(popularCollectionView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        layoutScrollView()
        
        mealCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/10),
            
            firstWelcomingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            firstWelcomingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftDistance),
            firstWelcomingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150 + safeAreaInsets.top),
            
            secondWelcomingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            secondWelcomingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftDistance),
            secondWelcomingLabel.topAnchor.constraint(equalTo: firstWelcomingLabel.bottomAnchor, constant: 10),
            
            mealLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftDistance),
            mealLabel.topAnchor.constraint(equalTo: secondWelcomingLabel.bottomAnchor, constant: 20),
            
            mealCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mealCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mealCollectionView.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: 15),
            mealCollectionView.heightAnchor.constraint(equalToConstant: Constants.mealCollectionHeight),
            
            popularLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftDistance),
            popularLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.rightDistance),
            popularLabel.topAnchor.constraint(equalTo: mealCollectionView.bottomAnchor, constant: 30),
            
            popularCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            popularCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 15),
            popularCollectionView.heightAnchor.constraint(equalToConstant: Constants.popularCollectionHeight),
            popularCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func layoutScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
}
