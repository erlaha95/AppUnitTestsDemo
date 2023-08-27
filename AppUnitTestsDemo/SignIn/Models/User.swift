//
//  User.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let username: String
    let firstName: String
    let lastName: String
    let age: Int
}

extension DBUser {
    var asUser: User {
        User(id: id, username: username, firstName: firstName, lastName: lastName, age: age)
    }
}
