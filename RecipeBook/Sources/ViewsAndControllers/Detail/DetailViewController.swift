//
//  DetailViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

class DetailViewController: CViewController<DetailView> {
    var recipeData: Recipe!
    
    init(recipeData: Recipe) {
        self.recipeData = recipeData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        view = DetailView(data: recipeData)
    }
    
    override func viewDidLoad() {
        customView.ingredientsCollectionView.delegate = self
        customView.ingredientsCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
