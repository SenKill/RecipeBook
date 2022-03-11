//
//  SearchTableView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/7/22.
//

import UIKit

class SearchTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = UIColor.theme.background
        register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseId)
        rowHeight = 125
        // separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
