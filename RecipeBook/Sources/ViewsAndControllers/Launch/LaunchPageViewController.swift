//
//  LaunchPageViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 13.04.2022.
//

import Foundation
import UIKit

class LaunchPageViewController: UIPageViewController {
    
    private var pages: [UIViewController] = []
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewControllers()
        setViewControllers([pages[0]], direction: .forward, animated: true)
        delegate = self
        dataSource = self
    }
}

// MARK: - Internal
private extension LaunchPageViewController {
    func addViewControllers() {
        pages.append(LaunchViewController(page: .first))
        pages.append(LaunchViewController(page: .second))
        pages.append(LaunchViewController(page: .third))
    }
}

// MARK: - UIPageViewControllerDelegate
extension LaunchPageViewController: UIPageViewControllerDelegate {
    
}

// MARK: - UIPageViewControllerDataSource
extension LaunchPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        currentPageIndex = index - 1
        return pages[currentPageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count-1 else {
            return nil
        }
        currentPageIndex = index + 1
        return pages[currentPageIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentPageIndex
    }
}
