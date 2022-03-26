//
//  NutritionView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/26/22.
//

import Foundation
import UIKit

class NutritionView: CView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(icon: UIImage, text: String) {
        super.init(frame: .zero)
        populateView(icon: icon, text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setViews() {
        super.setViews()
        backgroundView.addSubview(iconView)
        addSubview(backgroundView)
        addSubview(label)
    }
    
    override func layoutViews() {
        super.layoutViews()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            label.leadingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }
    
    private func populateView(icon: UIImage, text: String) {
        iconView.image = icon
        label.text = text
    }
}
