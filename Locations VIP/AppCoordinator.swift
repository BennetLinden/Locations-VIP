//
//  AppCoordinator.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation
import UIKit

class AppCoordinator {
    private let navigationController = UINavigationController()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
    
        navigationController.viewControllers = [viewController]
        
        window.rootViewController = navigationController
    }
}
