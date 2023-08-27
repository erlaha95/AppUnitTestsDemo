//
//  SignInService.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

protocol SignInService {
    func signIn(user: SignInUser, completion: @escaping (Result<User, SignInError>) -> Void)
}

final class SignInServiceImpl: SignInService {
    
    private let repository: DBUsersRepository
    
    init(repository: DBUsersRepository) {
        self.repository = repository
    }
    
    func signIn(user: SignInUser, completion: @escaping (Result<User, SignInError>) -> Void) {
        
        guard let foundUser = repository.findUser(username: user.username) else {
            completion(.failure(.userDoesNotExist))
            return
        }
        
        guard foundUser.password == user.password else {
            completion(.failure(.wrongCredentials))
            return
        }
        
        completion(.success(foundUser.asUser))
    }
}
