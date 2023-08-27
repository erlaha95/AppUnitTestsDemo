//
//  SignInCoordinator.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import UIKit

protocol SignInCoordinatorDelegate: AnyObject {
    func signInCoordinator(_ coordinator: SignInCoordinator, didCompleteWith user: User)
}

final class SignInCoordinator: BaseCoordinator {
    
    weak var delegate: SignInCoordinatorDelegate?
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let viewController = SignInViewController()
        let repository = InMemoryDBUsersRepository()
        let service = SignInServiceImpl(repository: repository)
        let presenter = SignInPresenterImpl(service: service)
        presenter.delegate = self
        
        viewController.presenter = presenter
        window.rootViewController = viewController
    }
}

extension SignInCoordinator: SignInPresenterDelegate {
    func signInCompleted(with user: User) {
        delegate?.signInCoordinator(self, didCompleteWith: user)
    }
}
