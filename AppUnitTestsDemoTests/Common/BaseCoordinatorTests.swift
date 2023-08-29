//
//  BaseCoordinatorTests.swift
//  AppUnitTestsDemoTests
//
//  Created by Yerlan Ismailov on 25.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import XCTest
@testable import AppUnitTestsDemo

final class BaseCoordinatorTests: XCTestCase {

    func test_addChild() {
        let parentCoordinator = BaseCoordinator()
        let childCoordinator = BaseCoordinator()
        
        // when
        parentCoordinator.add(childCoordinator: childCoordinator)
        
        // then
        XCTAssertTrue(parentCoordinator.childCoordinators.contains(where: { $0 === childCoordinator }))
    }
}
