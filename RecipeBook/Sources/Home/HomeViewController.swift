//
//  HomeViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeViewController: CViewController<HomeView> {
    private var mealRecipes: [RecipeModel] = []
    private var popularRecipes: [RecipeModel] = []
    
    lazy var mealVC = MealViewController()
    lazy var popularVC = PopularViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        setUpLabels()
        addChildVCs()
    }
}


// MARK: - Internal

extension HomeViewController {
    
    private func addChildVCs() {
        customView.mealCollectionView.delegate = mealVC
        customView.mealCollectionView.dataSource = mealVC
        
        addChild(mealVC)
        mealVC.recipes = mealRecipes
        mealVC.didMove(toParent: self)
        
        customView.popularCollectionView.delegate = popularVC
        customView.popularCollectionView.dataSource = popularVC
        
        addChild(popularVC)
        popularVC.recipes = popularRecipes
        popularVC.didMove(toParent: self)
    }
    
    private func fetchData() {
        let data = RecipeData()
        self.mealRecipes = data.getMealRecipes()
        self.popularRecipes = data.getPopularRecipes()
    }
    
    private func setUpLabels() {
        guard let hours = Date.getHoursOnly() else {
            print("ERROR: Date hours is nil")
            return
        }
        
        switch hours {
        case let hour where 6...11 ~= hour:
            customView.firstWelcomingLabel.text = "Good morning!🌅"
            customView.mealLabel.text = "Breakfast"
            break
        case let hour where 12...16 ~= hour:
            customView.firstWelcomingLabel.text = "Good afternoon!☀️"
            customView.mealLabel.text = "Lunch"
            break
        case let hour where 17...23 ~= hour:
            customView.firstWelcomingLabel.text = "Good evening!🌇"
            customView.mealLabel.text = "Dinner"
            break
        case let hour where 0...5 ~= hour:
            customView.firstWelcomingLabel.text = "Good night!🌙"
            customView.mealLabel.text = "Snacks"
        default:
            print("Unexpected hours value")
            break
        }
    }
}
