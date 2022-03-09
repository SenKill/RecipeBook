//
//  SearchTableViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/26/22.
//

import UIKit

class SearchTableViewController: UITableViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var randomRecipes: [Recipe] = []
    private var fetchedRecipes: [Recipe] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var debounceTimer: Timer?
    
    override func loadView() {
        super.loadView()
        tableView = SearchTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomRecipes()
        configureSearchController()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return fetchedRecipes.count
        }
        return Constants.searchDefaultCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath)
        guard let newCell = cell as? SearchTableViewCell else {
            print("ERROR: Cannot configure cell")
            return cell
        }
        
        var recipe: Recipe?
        
        if isFiltering {
            recipe = fetchedRecipes[indexPath.row]
        } else if randomRecipes.count != 0 {
            recipe = randomRecipes[indexPath.row]
        }
        
        newCell.configureCell(for: recipe, with: nil)
        
        if let image = recipe?.image {
            NetworkService.fetchImage(for: .recipe, from: image, size: nil) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        newCell.configureCell(for: recipe, with: UIImage(data: data))
                    }
                case . failure(let error):
                    print("Loading image error: \(error.localizedDescription)")
                }
            }
        } else if recipe?.title != nil {
            newCell.configureCell(for: recipe, with: UIImage.image.defaultRecipe)
        }
        
        return newCell
    }
}

// MARK: - Internal
extension SearchTableViewController {
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchRandomRecipes() {
        NetworkService.fetchRecipes(.search(for: .random, count: Constants.searchDefaultCount, tags: [])) { result in
            switch result {
            case .success(let data):
                if let recipes = data.recipes {
                    DispatchQueue.main.async {
                        self.randomRecipes = recipes
                        print(recipes.count)
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        debounceTimer?.invalidate()
        if let text = searchController.searchBar.text, isFiltering {
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                self.findContentForSearchText(text)
            }
        } else {
            tableView.reloadData()
        }
    }
    
    private func findContentForSearchText(_ searchText: String) {
        NetworkService.fetchRecipes(.search(for: .complexSearch, matching: searchText, count: Constants.searchCount, tags: [])) { result in
            switch result {
            case .success(let data):
                if let recipes = data.results {
                    DispatchQueue.main.async {
                        self.fetchedRecipes = recipes
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error while fetching from complex search: \(error.localizedDescription)")
            }
        }
    }
}
