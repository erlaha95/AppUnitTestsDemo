//
//  AppCoordinator.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let signInCoordinator = SignInCoordinator(window: window)
        signInCoordinator.delegate = self
        signInCoordinator.start()
        add(childCoordinator: signInCoordinator)
    }
    
}

extension AppCoordinator: SignInCoordinatorDelegate {
    
    func signInCoordinator(_ coordinator: SignInCoordinator, didCompleteWith user: User) {
        remove(childCoordinator: coordinator)
        // move to next coordinator
        print("AppCoordinator: Sign In Completed. We can go to the next flow")
    }
}
