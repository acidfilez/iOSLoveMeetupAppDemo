//
//  MainCoordinator.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class MainCoordinator: Coordinator {
    
    private unowned let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private var eventsCoordinator: Coordinator?
    private var membersCoordinator: Coordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewControllers = [UINavigationController(), UINavigationController()]
        let dataManager = ModelDataManagerDefault()
        
        eventsCoordinator = EventsCoordinator(navigationController: viewControllers[0],
                                              dataManager: dataManager)
        eventsCoordinator?.start()
        membersCoordinator = MembersCoordinator(navigationController: viewControllers[1], dataManager: dataManager)
        membersCoordinator?.start()
        tabBarController.viewControllers = viewControllers
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
