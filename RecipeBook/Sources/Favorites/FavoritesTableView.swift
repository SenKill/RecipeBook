//
//  FavoritesTableView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 4/4/22.
//

import Foundation
import UIKit

class FavoritesTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = UIColor.theme.background
        register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseId)
        rowHeight = 125
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
