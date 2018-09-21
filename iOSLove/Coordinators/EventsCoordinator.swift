//
//  EventsCoordinator.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class EventsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let dataManager: ModelDataManager
    
    init(navigationController: UINavigationController, dataManager: ModelDataManager) {
        self.navigationController = navigationController
        self.dataManager = dataManager
    }
    
    func start() {
        let viewController = EventsListWireframe.viewController(withDelegate: self, dataManager: dataManager)
        navigationController.viewControllers = [viewController]
        // Forces the navigation controller to render
        _ = navigationController.view
    }
}

extension EventsCoordinator: EventsListViewDelegate {
    
}
