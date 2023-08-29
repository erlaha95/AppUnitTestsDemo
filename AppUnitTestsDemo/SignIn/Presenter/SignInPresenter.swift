//
//  SignInPresenter.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import Foundation

enum SignInError: LocalizedError, Equatable {
    
    case userDoesNotExist
    case wrongCredentials
    
    var errorDescription: String? {
        switch self {
        case .userDoesNotExist:
            return "User does not exist"
        case .wrongCredentials:
            return "Wrong credentials"
        }
    }
}

protocol SignInPresenter: AnyObject {
    func signIn(user: SignInUser)
}

protocol SignInPresenterDelegate: AnyObject {
    func signInCompleted(with user: User)
}

final class SignInPresenterImpl {
    
    private let service: SignInService
    
    weak var view: SignInViewProtocol?
    weak var delegate: SignInPresenterDelegate?
    
    init(service: SignInService) {
        self.service = service
    }
}

extension SignInPresenterImpl: SignInPresenter {
    
    func signIn(user: SignInUser) {
        service.signIn(user: user) { [weak self] result in
            switch result {
            case .success(let signedInUser):
                self?.delegate?.signInCompleted(with: signedInUser)
            case .failure(let error):
                self?.view?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
