//
//  EventCellPresenter.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal protocol EventCellPresenter: class {
    var name: String { get }
    var venueName: String { get }
    var status: String { get }
}

internal final class EventCellPresenterImpl {
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
}

extension EventCellPresenterImpl: EventCellPresenter {
    var name: String {
        return event.name.capitalized
    }
    
    var venueName: String {
        return event.venue.name.capitalized
    }
    
    var status: String {
        return event.status.rawValue.capitalized
    }
}
