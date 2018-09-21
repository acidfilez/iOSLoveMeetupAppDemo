//
//  AllMembersWireframe.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal protocol AllMembersViewDelegate: class {
    func allMembersView(_ viewController: AllMembersViewController, didSelect member: Member)
}

internal struct AllMembersWireframe {
    static func viewController(withDelegate delegate: AllMembersViewDelegate, dataManager: ModelDataManager) -> UIViewController {
        let interactor = MembersInteractorImpl(dataManager: dataManager)
        let presenter = AllMembersPresenterImpl(interactor: interactor)
        let vc = AllMembersViewController(presenter: presenter)
        
        presenter.onSelectItem = { [weak delegate, unowned vc] member in
            delegate?.allMembersView(vc, didSelect: member)
        }
        
        return vc
    }
}
