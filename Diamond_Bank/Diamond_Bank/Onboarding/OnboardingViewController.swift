//
//  OnboardingViewController.swift
//  Diamond_Bank
//
//  Created by Sailau Almaz Maratuly on 25.11.2022.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {
  
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private let animationView = LottieAnimationView()
    
    private var animationName: String
    private let titleText: String
    private let descriptionTitleText: String
    
    init (animationName: String, titleText: String, descriptionTitleText: String) {
        
        self.animationName = animationName
        self.titleText = titleText
        self.descriptionTitleText = descriptionTitleText
        
        animationView.animation = LottieAnimation.named(animationName)
        titleLabel.text = titleText
        descriptionTitleLabel.text = descriptionTitleText
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupAnimation()
        addSubviews()
        addConstraints()
    }

}

// MARK: Add subviews and constraints
extension OnboardingViewController {
    
    func addSubviews() {

        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionTitleLabel)
        
        view.addSubview(stackView)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        
    }
}

// MARK: Lottie Animation
extension OnboardingViewController {
    func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .white
        animationView.frame = view.bounds
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = .loop
        animationView.play()
    }
}
