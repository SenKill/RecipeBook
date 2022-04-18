//
//  SearchTableViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/26/22.
//

import UIKit

class SearchTableViewController: UITableViewController {

    // MARK: - Properties
    private var searchController: RecipesSearchController!
    
    private var randomRecipes: [Recipe] = []
    private var fetchedRecipes: [Recipe] = []
    
    private var isSearching: Bool = false
    private var isChangingFilters: Bool = false
    
    private var filterViewController: FilterViewController!
    
    private var selectedSegment: Int = 0
    private var selectedMealType: String? {
        guard let scopeTitles = searchController?.searchBar.scopeButtonTitles else {
            return nil
        }
        if scopeTitles[selectedSegment] == "Any" {
            return nil
        }
        return scopeTitles[selectedSegment]
    }
    
    // MARK: - Life cycle
    override func loadView() {
        tableView = SearchTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomRecipes()
        configureSearchController()
        configureFilterViewController()
        definesPresentationContext = true
    }
}

// MARK: - FavoriteButtonDelegate
extension SearchTableViewController: FavoriteButtonDelegate {
    func didTapFavoriteButton(_ sender: FavoriteButton, index: IndexPath) {
        guard (isSearching && !fetchedRecipes.isEmpty) || (!isSearching && !randomRecipes.isEmpty) else {
            return
        }
        let recipes = isSearching ? fetchedRecipes : randomRecipes
        if sender.tintColor == UIColor.systemRed {
            LocalService.shared.removeObjectFromFavorites(with: recipes[index.row].id)
            if isSearching {
                fetchedRecipes[index.row].isFavorite = false
            } else {
                randomRecipes[index.row].isFavorite = false
            }
            sender.setInactive()
        } else {
            LocalService.shared.addToFavorites(recipes[index.row])
            if isSearching {
                fetchedRecipes[index.row].isFavorite = true
            } else {
                randomRecipes[index.row].isFavorite = true
            }
            sender.setActive()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailViewController: DetailViewController!
        if isSearching && !fetchedRecipes.isEmpty {
            detailViewController = DetailViewController(with: fetchedRecipes[indexPath.row], index: indexPath)
        } else if !randomRecipes.isEmpty {
            detailViewController = DetailViewController(with: randomRecipes[indexPath.row], index: indexPath)
        } else {
            return
        }
        detailViewController.delegate = self
        present(detailViewController, animated: true)
    }
}

// MARK: - DetailViewControllerDelegate
extension SearchTableViewController: DetailViewControllerDelegate {
    func detailViewController(didToggleFavoriteWithIndex index: IndexPath, value: Bool, cell: RecipesCollectionViewCell?) {
        if isSearching {
            fetchedRecipes[index.row].isFavorite = value
        } else {
            randomRecipes[index.row].isFavorite = value
        }
        tableView.reloadRows(at: [index], with: .automatic)
    }
}

// MARK: - UITableViewDataSource
extension SearchTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return fetchedRecipes.count
        }
        return Constants.searchDefaultCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId, for: indexPath)
        guard let newCell = cell as? SearchTableViewCell else {
            let alert = UIAlertController.errorAlert(message: "Cannot configure cell")
            self.present(alert, animated: true, completion: nil)
            return cell
        }
        
        var recipe: Recipe?
        
        if isSearching {
            recipe = fetchedRecipes[indexPath.row]
        } else if randomRecipes.count != 0 {
            recipe = randomRecipes[indexPath.row]
        }
        
        newCell.configureCell(for: recipe, with: nil)
        newCell.index = indexPath
        newCell.delegate = self
        
        if let image = recipe?.image {
            NetworkService.fetchImage(for: .recipe, with: image.changeImageSize(to: ImageSizes.verySmall), size: nil) { result in
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
        } else if recipe?.title != nil {
            newCell.configureCell(for: recipe, with: UIImage.images.defaultRecipe)
        }
        
        return newCell
    }
}

// MARK: - UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate {
    // Presents searched recipes
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            fetchRecipesForSearchText(text.lowercased())
            if isChangingFilters {
                toggleFilterView()
            }
            isSearching = true
        }
    }
    
    // Presents default recipes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Updates the table view only if the text field is empty and default recipes don't already present.
        if let text = searchBar.text, text.isEmpty && isSearching {
            isSearching = false
            tableView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedSegment = selectedScope
    }
}

// MARK: - UISearchBarFilterDelegate
extension SearchTableViewController: UISearchBarFilterDelegate {
    func toggleFilterView() {
        if isChangingFilters {
            changeFilterButtonAppearance(with: .systemGreen, and: .systemBackground)
            navigationController?.popViewController(animated: true)
        } else {
            changeFilterButtonAppearance(with: .systemBackground, and: .systemGreen)
            navigationController?.pushViewController(filterViewController, animated: true)
        }
        searchController.searchBar.setShowsScope(!isChangingFilters, animated: true)
        isChangingFilters.toggle()
    }
}

// MARK: - Internal
private extension SearchTableViewController {
    func configureSearchController() {
        searchController = RecipesSearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.filterDelegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.setShowsScope(true, animated: false)
    }
    
    func configureFilterViewController() {
        filterViewController = FilterViewController()
        filterViewController.navigationItem.searchController = searchController
    }
    
    func fetchRandomRecipes() {
        var filterParameters = FilterParameters()
        filterParameters.sort = "random"
        
        NetworkService.fetchRecipes(.searchWithFilter(filterParameters, query: nil, number: Constants.searchDefaultCount)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let recipes = data.results {
                        self.randomRecipes = recipes
                        self.tableView?.reloadData()
                    }
                case .failure(let error):
                    let alert = UIAlertController.errorAlert(title: "Recipes loading failure", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func fetchRecipesForSearchText(_ searchText: String) {
        var filterParameters = filterViewController.getFilterParameters()
        filterParameters.type = selectedMealType
        
        NetworkService.fetchRecipes(.searchWithFilter(filterParameters, query: searchText, number: Constants.searchCount)) { result in
            switch result {
            case .success(let data):
                if let recipes = data.results {
                    DispatchQueue.main.async {
                        self.fetchedRecipes = recipes
                        self.tableView?.reloadData()
                    }
                }
            case .failure(let error):
                let alert = UIAlertController.errorAlert(title: "Complex recipes loading failure", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func changeFilterButtonAppearance(with firstColor: UIColor, and secondColor: UIColor) {
        let button: UIButton = searchController.searchBar.filterButton
        button.tintColor = firstColor
        button.backgroundColor = secondColor
    }
}
