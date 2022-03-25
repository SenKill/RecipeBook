//
//  DetailView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

class DetailView: CView {
    
    init(data recipe: Recipe) {
        super.init(frame: .zero)
        configureViewsWithData(recipe)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prepTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setViews() {
        super.setViews()
        addSubview(titleLabel)
        addSubview(sourceLabel)
        addSubview(prepTimeLabel)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            prepTimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            prepTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            titleLabel.topAnchor.constraint(equalTo: prepTimeLabel.topAnchor),
            
            sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func configureViewsWithData(_ recipe: Recipe) {
        titleLabel.text = recipe.title
        sourceLabel.text = "by: \(recipe.sourceName ?? "undefined")"
        
        let prepTime: String = "\(recipe.readyInMinutes) Min"
        prepTimeLabel.setLabelWithIcon(UIImage(systemName: "alarm")!, text: prepTime)
        
    }
}
