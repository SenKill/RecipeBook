//
//  HomeViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeViewController: CViewController<HomeView> {
    private var mealRecipes: [Recipe] = []
    private var popularRecipes: [Recipe] = []
    
    private var meal: String = ""
    private var welcomingText: String = ""
    
    lazy var mealVC = MealViewController()
    lazy var popularVC = PopularViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignLabelTexts()
        fetchData()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        customView.firstWelcomingLabel.text = welcomingText
        customView.mealLabel.text = meal
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
        NetworkService.fetchRecipes(.search(for: .random, count: 15, tags: [meal])) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.mealRecipes = data.recipes
                    self.addChildVCs()
                case .failure(let error):
                    // TODO: Handle error better
                    print("Data loading failure: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func assignLabelTexts() {
        guard let hours = Date.getHoursOnly() else {
            print("ERROR: Date hours is nil")
            return
        }
        
        let labelTexts = TimeLogic.getLabels(from: hours)
        welcomingText = labelTexts[0]
        meal = labelTexts[1]
    }
}
