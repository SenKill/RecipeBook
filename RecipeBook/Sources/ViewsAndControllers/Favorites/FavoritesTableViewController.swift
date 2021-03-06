//
//  FavoritesTableViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/4/22.
//

import Foundation
import UIKit

class FavoritesTableViewController: UITableViewController {
    
    private var recipes: [Recipe] = []
    private let localService = LocalService()
    private let networkService = NetworkService.shared
    
    override func loadView() {
        tableView = FavoritesTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = localService.getFavorites()
        tableView.reloadData()
    }
}

// MARK: - Internal
private extension FavoritesTableViewController {
    // Posting the changed favorite value with recipe id to all ViewControllers that observe notifications
    // To change their old value to the new one
    func postToNotificationCenter(_ id: Int, value: Bool) {
        NotificationCenter.default.post(name: .favoriteChanged, object: value, userInfo: [Notification.UserInfoKeys.id: id])
    }
}

// MARK: - DetailViewControllerDelegate
extension FavoritesTableViewController: DetailViewControllerDelegate {
    func detailViewController(didToggleFavoriteWithIndex index: IndexPath, value: Bool, cell: RecipesCollectionViewCell?) {
        recipes[index.row].isFavorite = value
        NotificationCenter.default.post(name: .favoriteChanged, object: value, userInfo: [Notification.UserInfoKeys.id: recipes[index.row].id])
    }
}

// MARK: - UITableViewDelegate
extension FavoritesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(with: recipes[indexPath.row], index: indexPath)
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let recipeId = recipes[indexPath.row].id
            postToNotificationCenter(recipeId, value: false)
            localService.removeObjectFromFavorites(with: recipes[indexPath.row].id)
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoritesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseId, for: indexPath)
        guard let newCell = cell as? FavoritesTableViewCell else {
            let alert = UIAlertController.errorAlert(message: "Cannot configure cell")
            self.present(alert, animated: true, completion: nil)
            return cell
        }
        
        let recipe = recipes[indexPath.row]
        newCell.configureCell(for: recipe, with: nil)
        guard let image = recipe.image else {
            return newCell
        }
        
        networkService.fetchImage(for: .recipe, with: image.changeImageSize(to: ImageSizes.verySmall), size: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    newCell.configureCell(for: recipe, with: UIImage(data: data))
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(title: "Loading image error", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        return newCell
    }
}
