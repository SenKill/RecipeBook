//
//  RecipesSearchBar.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/10/22.
//

import UIKit

protocol UISearchBarFilterDelegate: class {
    func toggleFilterView()
}

class RecipesSearchBar: UISearchBar {
    
    enum Names {
        static let searchField = "searchField"
        static let slider = "slider.horizontal.3"
    }
    
    weak var filterDelegate: UISearchBarFilterDelegate?
    
    private lazy var textField: UITextField? = {
        guard let textField = value(forKey: Names.searchField) as? UITextField else {
            print("ERROR: Can't get UITextField from SearchBar")
            return nil
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        
        button.setImage(UIImage(systemName: Names.slider), for: .normal)
        button.tintColor = .systemGreen
        
        button.layer.cornerRadius = 13
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.25
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setViews() {
        placeholder = "Search recipes here..."
        scopeButtonTitles = ["Any", "Brekfast", "Main course", "Side dish", "Snack"]
        guard let textField = textField else {
            return
        }
        
        textField.leftView?.tintColor = .systemGreen
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowOpacity = 0.25
        let textFieldBackground = textField.subviews.first
        // Allows to change searchTextField's background color
        textFieldBackground?.subviews.forEach({ $0.removeFromSuperview() })
        filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        addSubview(filterButton)
    }
    
    func layoutViews() {
        guard let textField = textField else {
            return
        }
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            filterButton.topAnchor.constraint(equalTo: textField.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            filterButton.widthAnchor.constraint(equalTo: filterButton.heightAnchor),
        ])
    }
}

private extension RecipesSearchBar {
    @objc func didTapFilterButton() {
        filterDelegate?.toggleFilterView()
    }
}
