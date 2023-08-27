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
    
    func test_signIn_serviceSignInCalled() {
        // given
        let (presenter, serviceSpy) = makeSUT()
        let signInUser = anySignInUser()
        
        // when
        presenter.signIn(user: signInUser)
        
        // then
        XCTAssertEqual(signInUser, serviceSpy.signInUser)
    }
    
    private func makeSUT() -> (SignInPresenter, SignInServiceSpy) {
        let service = SignInServiceSpy()
        let presenter = SignInPresenterImpl(service: service)
        return (presenter, service)
    }
    
    private func anySignInUser() -> SignInUser {
        SignInUser(username: "", password: "")
    }
    
    private func user(for signInUser: SignInUser) -> User {
        User(id: "", username: signInUser.username, firstName: "", lastName: "", age: 0)
    }
}

final class SignInServiceSpy: SignInService {
    
    var signInUser: SignInUser?
    
    func signIn(user: SignInUser, completion: @escaping (Result<User, SignInError>) -> Void) {
        signInUser = user
    }
}

extension SignInUser: Equatable{
    public static func == (lhs: SignInUser, rhs: SignInUser) -> Bool {
        lhs.username == rhs.username && lhs.password == rhs.password
    }
}
