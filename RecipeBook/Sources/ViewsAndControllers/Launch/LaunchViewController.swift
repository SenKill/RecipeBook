//
//  LaunchViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 13.04.2022.
//

import Foundation
import UIKit

class LaunchViewController: CViewController<LaunchView> {
    enum Page: String {
        case first = "firstImage"
        case second = "secondImage"
        case third = "thirdImage"
    }
    
    private var page: Page!
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.backgroundGradientCover.frame = customView.backgroundImageView.bounds
    }
    
    private func configureView() {
        customView.backgroundImageView.image = UIImage(named: page.rawValue)
        customView.backgroundGradientCover.frame = customView.backgroundImageView.bounds
        customView.delegate = self
        switch page {
        case .first:
            customView.titleTextLabel.text = "Welcome to the «RecipeBook!»"
            customView.bodyTextLabel.text = "Cook tasty food with our recipes!\n(You can scroll screen horizontally)"
        case .second:
            customView.titleTextLabel.text = "Smart search"
            customView.bodyTextLabel.text = "Search recipes with ingredients you currently have, by nutrients, or just write a name of a dish!"
        case .third:
            customView.titleTextLabel.text = "Many cuisines"
            customView.bodyTextLabel.text = "Here you can find almost all around the world cuisines from African to Japanese!"
        default:
            print("Undefined value")
        }
    }
}

 // MARK: - LaunchViewDelegate
extension LaunchViewController: LaunchViewDelegate {
    func launchView(didTapReadyButton button: UIButton) {
        UserDefaults.standard.set(true, forKey: UserDefaults.keys.isUserReady)
        
        let tabBarController = RecipeTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .partialCurl
        // show(tabBarController, sender: self)
        present(tabBarController, animated: true)
    }
}
