//
//  SignInViewController.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

final class SignInViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.configuration = .bordered()
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: SignInPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        [usernameTextField, passwordTextField, signInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            signInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func signInButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        presenter?.signIn(user: .init(username: username, password: password))
    }
    
}

extension SignInViewController: SignInViewProtocol {
    func showAlert(title: String, message: String) {
    }
}
