//
//  LaunchPageViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 13.04.2022.
//

import Foundation
import UIKit

class LaunchPageViewController: UIPageViewController {
    
    private var pageVCs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewControllers()
        setViewControllers([pageVCs[0]], direction: .forward, animated: true)
        delegate = self
        dataSource = self
    }
}

// MARK: - Internal
private extension LaunchPageViewController {
    func addViewControllers() {
        pageVCs.append(LaunchViewController(page: .first))
        pageVCs.append(LaunchViewController(page: .second))
        pageVCs.append(LaunchViewController(page: .third))
    }
}

// MARK: - UIPageViewControllerDelegate
extension LaunchPageViewController: UIPageViewControllerDelegate {
    
}

// MARK: - UIPageViewControllerDataSource
extension LaunchPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageVCs.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pageVCs[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageVCs.firstIndex(of: viewController), index < pageVCs.count-1 else {
            return nil
        }
        return pageVCs[index+1]
    }
}
