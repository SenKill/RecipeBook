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
    
    private let notificationCenter = NotificationCenter.default
    
    deinit {
        notificationCenter.removeObserver(self, name: .favoriteChanged, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignLabelTexts()
        fetchData()
        addChildVCs()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        customView.firstWelcomingLabel.text = welcomingText
        customView.mealLabel.text = meal
        
        customView.backgroundCoverLayer.frame = customView.backgroundView.bounds
        
        notificationCenter.addObserver(self, selector: #selector(favoriteChanged(_:)), name: .favoriteChanged, object: nil)
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
    
    @objc func favoriteChanged(_ notification: Notification) {
        guard let value = notification.object as? Bool,
              let id = notification.userInfo?[Notification.UserInfoKeys.id] as? Int else {
            return
        }
        
        print("Changing value from post")
        toggleFavoriteRecipe(for: mealVC, with: id, value: value)
        toggleFavoriteRecipe(for: popularVC, with: id, value: value)
        customView.mealCollectionView.reloadData()
        customView.popularCollectionView.reloadData()
    }
    
    func toggleFavoriteRecipe(
        for viewController: RecipesCollectionViewController,
        with id: Int, value: Bool) {
        for i in 0 ..< viewController.recipes.count {
            if viewController.recipes[i].id == id {
                viewController.recipes[i].isFavorite = value
            }
        }
    }
}
