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
    
    lazy var mealVC = MealViewController()
    lazy var popularVC = PopularViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        setUpLabels()
        
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
        NetworkService.fetchRecipes(.search(for: .random, count: 10)) { result in
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
    
    private func setUpLabels() {
        guard let hours = Date.getHoursOnly() else {
            print("ERROR: Date hours is nil")
            return
        }
        
        let labelTexts = TimeLogic.getLabels(from: hours)
        
        customView.firstWelcomingLabel.text = labelTexts[0]
        customView.mealLabel.text = labelTexts[1]
    }
}
