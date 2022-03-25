//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

class DetailViewController: CViewController<DetailView> {
    let recipeData: Recipe
    
    init(recipeData: Recipe) {
        self.recipeData = recipeData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView(data: recipeData)
    }
}
