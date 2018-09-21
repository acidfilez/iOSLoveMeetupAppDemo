//
//  EventsListWireframe.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal protocol EventsListViewDelegate {
    
}

internal struct EventsListWireframe {
    static func viewController(withDelegate delegate: EventsListViewDelegate, dataManager: ModelDataManager) -> UIViewController {
        // TODO: Do something with the delegate
        let interactor = EventsInteractorImpl(dataManager: dataManager)
        let presenter = EventsListPresenterImpl(interactor: interactor)
        return EventsListViewController(presenter: presenter)
    }
}
