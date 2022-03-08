//
//  HomeViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

class HomeViewController: CViewController<HomeView> {
    private var meal: String = ""
    private var welcomingText: String = ""
    
    private let mealVC = RecipesCollectionViewController()
    private let popularVC = RecipesCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignLabelTexts()
        fetchData()
        addChildVCs()
        
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
        mealVC.didMove(toParent: self)
        
        customView.popularCollectionView.delegate = popularVC
        customView.popularCollectionView.dataSource = popularVC
        
        addChild(popularVC)
        popularVC.didMove(toParent: self)
    }
    
    private func fetchData() {
        NetworkService.fetchRecipes(.search(for: .random, count: Constants.mealCount, tags: [meal])) { result in
            switch result {
            case .success(let data):
                if let recipes = data.recipes {
                    DispatchQueue.main.async {
                        self.mealVC.recipes = recipes
                        self.customView.mealCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                // TODO: Handle error better
                print("Meal data loading failure: \(error.localizedDescription)")
            }
        }
        
        NetworkService.fetchRecipes(.search(for: .random, count: Constants.popularCount, tags: [])) { result in
            switch result {
            case .success(let data):
                if let recipes = data.recipes {
                    DispatchQueue.main.async {
                        self.popularVC.recipes = recipes
                        self.customView.popularCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print("Popular data loading failure: \(error.localizedDescription)")
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
