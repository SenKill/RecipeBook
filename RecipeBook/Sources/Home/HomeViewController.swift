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
    
    lazy var mealVC = RecipesCollectionViewController()
    lazy var popularVC = RecipesCollectionViewController()
    
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
        let group = DispatchGroup()
        
        group.enter()
        NetworkService.fetchRecipes(.search(for: .random, count: Constants.mealRows, tags: [meal])) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.mealRecipes = data.recipes
                    group.leave()
                case .failure(let error):
                    // TODO: Handle error better
                    print("Meal data loading failure: \(error.localizedDescription)")
                    group.leave()
                }
            }
        }
        
        group.enter()
        NetworkService.fetchRecipes(.search(for: .random, count: Constants.popularRows, tags: [])) { result in
            switch result {
            case .success(let data):
                self.popularRecipes = data.recipes
                group.leave()
            case .failure(let error):
                print("Popular data loading failure: \(error.localizedDescription)")
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.addChildVCs()
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
