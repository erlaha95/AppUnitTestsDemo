//
//  DBUsersRepository.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import Foundation

protocol DBUsersRepository {
    func findUser(username: String) -> DBUser?
}

final class InMemoryDBUsersRepository: DBUsersRepository {
    
    private let users: [DBUser] = [
        .init(
            id: "1",
            username: "yerlan.ismailov",
            password: "123456",
            firstName: "Yerlan",
            lastName: "Ismailov",
            age: 28
        )
    ]
    
    func findUser(username: String) -> DBUser? {
        guard let user = users.first(where: { $0.username == username }) else { return nil }
        return user
    }
}
