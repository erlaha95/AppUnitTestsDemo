//
//  SampleTests.swift
//  AppUnitTestsDemoTests
//
//  Created by Yerlan Ismailov on 28.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import XCTest

final class SampleTests: XCTestCase {
    
    let account = Account(balance: 1000)
    
    func test_withdraw1() {
        // when
        account.withdraw(amount: 100)
        
        XCTAssertEqual(account.balance, 900)
    }
    
    func test_withdraw2() {
        // when
        account.withdraw(amount: 100)
        
        XCTAssertEqual(account.balance, 900)
    }
}

class Account {
    
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(amount: Double) {
        balance -= amount
    }
}
