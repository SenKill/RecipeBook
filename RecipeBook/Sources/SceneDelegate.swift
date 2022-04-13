//
//  SceneDelegate.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        let searchNavigationController = UINavigationController(rootViewController: SearchTableViewController())
        let favoritesNavigationController = UINavigationController(rootViewController: FavoritesTableViewController())
        let tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([homeNavigationController, searchNavigationController, favoritesNavigationController], animated: false)
        
        customizeTabBar(homeNavigationController, name: "Home")
        customizeTabBar(searchNavigationController, name: "Search")
        customizeTabBar(favoritesNavigationController, name: "Favorites")
        
        window = UIWindow(windowScene: windowsScene)
        window?.rootViewController = LaunchPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        window?.makeKeyAndVisible()
    }
    
    private func customizeTabBar(_ controller: UINavigationController, name: String) {
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

