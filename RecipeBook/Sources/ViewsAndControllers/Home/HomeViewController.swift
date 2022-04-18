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
    
    private var mealVC: RecipesCollectionViewController!
    private var popularVC: RecipesCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignLabelTexts()
        fetchData()
        addChildVCs()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        customView.firstWelcomingLabel.text = welcomingText
        customView.mealLabel.text = meal
        
        customView.backgroundCoverLayer.frame = customView.backgroundView.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.backgroundCoverLayer.frame = customView.backgroundView.bounds
    }
}

// MARK: - Internal
private extension HomeViewController {
    
    func addChildVCs() {
        mealVC = RecipesCollectionViewController()
        popularVC = RecipesCollectionViewController()
        
        customView.mealCollectionView.delegate = mealVC
        customView.mealCollectionView.dataSource = mealVC
        
        addChild(mealVC)
        mealVC.didMove(toParent: self)
        
        customView.popularCollectionView.delegate = popularVC
        customView.popularCollectionView.dataSource = popularVC
        
        addChild(popularVC)
        popularVC.didMove(toParent: self)
    }
    
    func fetchData() {
        NetworkService.fetchRecipes(.randomSearch(number: Constants.mealCount, tags: [meal])) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let recipes = data.recipes {
                        self.mealVC.recipes = recipes
                        self.customView.mealCollectionView.reloadData()
                    }
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(title: "Meal recipes loading failure", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        NetworkService.fetchRecipes(.randomSearch(number: Constants.popularCount)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let recipes = data.recipes {
                        self.popularVC.recipes = recipes
                        self.customView.popularCollectionView.reloadData()
                    }
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(title: "Popular recipes loading failure", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func assignLabelTexts() {
        guard let hours = Date.getHoursOnly() else {
            print("ERROR: Date hours is nil")
            return
        }
        
        let labelTexts = TimeLogic.getLabels(from: hours)
        welcomingText = labelTexts[0]
        meal = labelTexts[1]
    }
}

