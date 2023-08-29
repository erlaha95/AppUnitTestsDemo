//
//  SignInPresenterTests.swift
//  AppUnitTestsDemoTests
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import XCTest
@testable import AppUnitTestsDemo

final class SignInPresenterTests: XCTestCase {
    
    func test_signIn_Failure() throws {
        // given
        let mockService = MockSignInService()
        let view = SpySignInView()
        let presenter = SignInPresenterImpl(service: mockService)
        presenter.view = view
        
        // when
        mockService.resultToReturn = .failure(.userDoesNotExist)
        presenter.signIn(user: .stub)
        
        // then
        let alertData = try XCTUnwrap(view.alertData)
        XCTAssertEqual(alertData.title, "Error")
        XCTAssertEqual(alertData.message, SignInError.userDoesNotExist.localizedDescription)
    }
}

extension SignInUser {
    static let stub = SignInUser(username: "abc", password: "123")
}

class MockSignInService: SignInService {
    
    var resultToReturn: Result<User, SignInError>?
    
    func signIn(user: SignInUser, completion: @escaping (Result<User, SignInError>) -> Void) {
        guard let resultToReturn else { return }
        completion(resultToReturn)
    }
}

class SpySignInView: SignInViewProtocol {
    
    var alertData: (title: String, message: String)?
    
    func showAlert(title: String, message: String) {
        alertData = (title, message)
    }
}

extension SignInUser: Equatable {
    
    public static func == (lhs: SignInUser, rhs: SignInUser) -> Bool {
        lhs.username == rhs.username && lhs.password == rhs.password
    }
}
