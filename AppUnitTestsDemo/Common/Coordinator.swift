//
//  Coordinator.swift
//  AppUnitTestsDemo
//
//  Created by Yerlan Ismailov on 24.08.2023.
//  Copyright © 2023 Tele2/Altel. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    func start()
}

class BaseCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    func start() {
    }
    
    func add(childCoordinator: Coordinator) {
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        childCoordinator.parentCoordinator = nil
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

class BaseNavigationControllerCoordinator: BaseCoordinator {
    
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

class NavigationControllerDelegateHandler: NSObject, UINavigationControllerDelegate {

    var viewControllerToCoordinatorMap: [UIViewController: Coordinator] = [:]

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {

        // Pop operation: From ViewController
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController)
        else {
            return
        }

        // Find and remove the corresponding coordinator from the parent
        if let coordinator = viewControllerToCoordinatorMap[fromViewController] {
            removeCoordinator(coordinator)
            viewControllerToCoordinatorMap.removeValue(forKey: fromViewController)
        }
    }

    // Function to remove the coordinator (you may have this function in a base coordinator class)
    private func removeCoordinator(_ coordinator: Coordinator) {
        // Your logic to remove the coordinator from its parent.
    }
}

