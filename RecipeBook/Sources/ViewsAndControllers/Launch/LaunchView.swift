//
//  LaunchView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 13.04.2022.
//

import Foundation
import UIKit

class LaunchView: CView {
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        let gradient = CAGradientLayer()
        let firstColor = UIColor.white.withAlphaComponent(0).cgColor
        let secondColor = UIColor.black.cgColor
        gradient.colors = [firstColor, secondColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        imageView.contentMode  = .scaleAspectFill
        
        imageView.layer.insertSublayer(gradient, at: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let textFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm ready!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = UIColor.theme.primaryTintColor
        button.tintColor = .white
        
        button.layer.shadowColor = button.backgroundColor?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 30
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setViews() {
        super.setViews()
        addSubview(backgroundImageView)
        textFrameView.addSubview(titleTextLabel)
        textFrameView.addSubview(bodyTextLabel)
        addSubview(textFrameView)
        addSubview(readyButton)
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleTextLabel.leadingAnchor.constraint(equalTo: textFrameView.leadingAnchor, constant: Constants.leftDistance),
            titleTextLabel.trailingAnchor.constraint(equalTo: textFrameView.trailingAnchor, constant: -Constants.rightDistance),
            titleTextLabel.topAnchor.constraint(equalTo: textFrameView.topAnchor, constant: 20),
            
            bodyTextLabel.leadingAnchor.constraint(equalTo: titleTextLabel.leadingAnchor),
            bodyTextLabel.trailingAnchor.constraint(equalTo: titleTextLabel.trailingAnchor),
            bodyTextLabel.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 20),
            
            textFrameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leftDistance),
            textFrameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.rightDistance),
            textFrameView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            textFrameView.bottomAnchor.constraint(equalTo: bodyTextLabel.bottomAnchor, constant: 20),
            
            readyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            readyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            readyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalTo: readyButton.widthAnchor, multiplier: 1/6)
        ])
    }
}
