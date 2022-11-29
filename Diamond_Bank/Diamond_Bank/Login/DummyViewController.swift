//
//  DummyViewController.swift
//  Diamond_Bank
//
//  Created by Sailau Almaz Maratuly on 30.11.2022.
//

import UIKit

class DummyViewContoller: UIViewController {
    
    weak var logoutDelegate: LogoutDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("Logout", for: [])
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
    }
}

// MARK: Add subviews and constraints
extension DummyViewContoller {
    
    func addSubviews() {
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: Actions
extension DummyViewContoller {
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        logoutDelegate?.didLogout()
    }
    
}

