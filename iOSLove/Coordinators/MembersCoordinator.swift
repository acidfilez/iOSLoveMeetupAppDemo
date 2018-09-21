//
//  MembersCoordinator.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class MembersCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let dataManager: ModelDataManager
    
    init(navigationController: UINavigationController, dataManager: ModelDataManager) {
        self.navigationController = navigationController
        self.dataManager = dataManager
    }
    
    func start() {
        let viewController = AllMembersWireframe.viewController(withDelegate: self, dataManager: dataManager)
        self.navigationController.viewControllers = [viewController]
        // Forces the navigation controller to render
        _ = navigationController.view
    }
}

extension MembersCoordinator: AllMembersViewDelegate {
    func allMembersView(_ viewController: AllMembersViewController, didSelect member: Member) {
        let vc = MemberWireframe.viewController(withDelegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension MembersCoordinator: MemberViewDelegate {
    
}
