//
//  LaunchView.swift
//  RecipeBook
//
//  Created by Serik Musaev on 13.04.2022.
//

import Foundation
import UIKit

protocol LaunchViewDelegate: AnyObject {
    func launchView(didTapReadyButton button: UIButton)
}

class LaunchView: CView {
    weak var delegate: LaunchViewDelegate?
    
    let backgroundGradientCover: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let firstColor = UIColor.black.withAlphaComponent(0).cgColor
        let secondColor = UIColor.black.withAlphaComponent(0.7).cgColor
        
        gradient.colors = [firstColor, secondColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode  = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.55)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
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
        button.layer.shadowOffset = CGSize(width: 2, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        button.layer.cornerRadius = 30
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setViews() {
        super.setViews()
        backgroundImageView.layer.addSublayer(backgroundGradientCover)
        addSubview(backgroundImageView)
        textFrameView.addSubview(titleTextLabel)
        textFrameView.addSubview(bodyTextLabel)
        addSubview(textFrameView)
        addSubview(readyButton)
        readyButton.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
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
            readyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalTo: readyButton.widthAnchor, multiplier: 1/6)
        ])
    }
    
    @objc func didTapReadyButton(_ button: UIButton) {
        delegate?.launchView(didTapReadyButton: button)
    }
}
