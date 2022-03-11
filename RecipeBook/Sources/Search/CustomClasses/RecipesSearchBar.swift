//
//  RecipesSearchBar.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/10/22.
//

import UIKit

class RecipesSearchBar: UISearchBar {
    
    private lazy var textField: UITextField? = {
        guard let textField = value(forKey: "searchField") as? UITextField else {
            print("ERROR: Can't get UITextField from SearchBar")
            return nil
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.25
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "slider.horizontal.3"))
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        guard let textField = textField else {
            return
        }
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowOpacity = 0.25
        
        let textFieldBackground = textField.subviews.first
        textFieldBackground?.backgroundColor = .white
        textFieldBackground?.subviews.forEach({ $0.removeFromSuperview() })
        filterButton.addSubview(filterIcon)
        textField.addSubview(filterButton)
    }
    
    func layoutViews() {
        guard let textField = textField else {
            return
        }
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            filterButton.topAnchor.constraint(equalTo: textField.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            filterButton.widthAnchor.constraint(equalTo: filterButton.heightAnchor),
            
            filterIcon.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor),
            filterIcon.centerXAnchor.constraint(equalTo: filterButton.centerXAnchor)
        ])
    }
}
