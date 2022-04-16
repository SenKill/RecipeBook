//
//  RecipeTabBarController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 16.04.2022.
//

import Foundation
import UIKit

class RecipeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        let searchNavigationController = UINavigationController(rootViewController: SearchTableViewController())
        let favoritesNavigationController = UINavigationController(rootViewController: FavoritesTableViewController())
        
        setViewControllers([homeNavigationController, searchNavigationController, favoritesNavigationController], animated: false)
        
        customizeTabBar(homeNavigationController, name: "Home")
        customizeTabBar(searchNavigationController, name: "Search")
        customizeTabBar(favoritesNavigationController, name: "Favorites")

    }
}

// MARK: Internal
private extension RecipeTabBarController {
    func customizeTabBar(_ controller: UINavigationController, name: String) {
        controller.viewControllers[0].title = name
        
        switch name {
        case "Home":
            controller.tabBarItem.image = UIImage(systemName: "house")
            controller.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
            controller.navigationBar.prefersLargeTitles = true
            
            guard let tabBar = controller.tabBarController?.tabBar else {
                print("ERROR: TabBar is nil")
                return
            }
            
            tabBar.tintColor = .systemGreen
            tabBar.layer.cornerRadius = 50
            tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            tabBar.layer.masksToBounds = true
            
            if #available(iOS 13.0, *) {
               let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
               tabBarAppearance.configureWithDefaultBackground()
               if #available(iOS 15.0, *) {
                  UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
               }
            }        case "Search":
            controller.tabBarItem.image = UIImage(systemName: "magnifyingglass")
            controller.tabBarItem.selectedImage = UIImage(systemName: "plus.magnifyingglass")
        case "Favorites":
            controller.tabBarItem.image = UIImage(systemName: "heart")
            controller.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        default:
            print("Undefined case")
            break
        }
    }
}
