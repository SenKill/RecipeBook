//
//  RecipesSearchController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/10/22.
//

import UIKit

class RecipesSearchController: UISearchController {

    let customSearchBar = RecipesSearchBar()
    
    override var searchBar: UISearchBar {
        return customSearchBar
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = true
        searchBar.showsBookmarkButton = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .blue
        obscuresBackgroundDuringPresentation = false
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
