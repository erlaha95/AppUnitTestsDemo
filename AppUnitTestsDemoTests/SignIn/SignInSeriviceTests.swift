//
//  SignInSeriviceTests.swift
//  AppUnitTestsDemoTests
//
//  Created by Yerlan Ismailov on 28.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import XCTest
@testable import AppUnitTestsDemo

final class SignInSeriviceTests: XCTestCase {
    
    func test_signIn_Success() {
        // given
        let (sut, repo) = makeSUT()
        let user = User(id: "1", username: "abc", firstName: "", lastName: "", age: 0)
        
        // when
        expect(sut: sut, toCompleteWith: .success(user)) {
            repo.dbUserToReturn = DBUser(
                id: "1",
                username: "abc",
                password: "123",
                firstName: "",
                lastName: "",
                age: 0
            )
        }
    }
    
    func test_signIn_Failure() {
        // given
        let (sut, repo) = makeSUT()
        
        // when
        expect(sut: sut, toCompleteWith: .failure(.userDoesNotExist)) {
            repo.dbUserToReturn = nil
        }
    }
    
    // MARK: - Helper method
    
    private func makeSUT() -> (SignInService, MockDBUsersRepository) {
        let mockRepo = MockDBUsersRepository()
        let service = SignInServiceImpl(repository: mockRepo)
        return (service, mockRepo)
    }
    
    private func expect(sut: SignInService, toCompleteWith expectedResult: Result<User, SignInError>, when action: @escaping () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        action()
        
        let exp = expectation(description: "Waiting for sign in")
        sut.signIn(user: .stub) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedUser), .success(expectedUser)):
                XCTAssertEqual(receivedUser, expectedUser, file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult), but got \(receivedResult)", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.username == rhs.username
    }
}

class MockDBUsersRepository: DBUsersRepository {
    
    var dbUserToReturn: DBUser?
    
    func findUser(username: String) -> DBUser? {
        return dbUserToReturn
    }
}
