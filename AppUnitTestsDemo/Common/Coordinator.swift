//
//  Coordinator.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
    }
    
    func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

class BaseNavigationControllerCoordinator: BaseCoordinator {
    
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, navigationControllerDelegate: UINavigationControllerDelegate) {
        self.navigationController = navigationController
        self.navigationController.delegate = navigationControllerDelegate
    }
    
}
