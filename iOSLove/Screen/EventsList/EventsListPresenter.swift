//
//  EventsListPresenter.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal protocol EventsListPresenter: class {
    var title: String { get }
    
    func load()
    var onUpdate: (() -> Void)? { set get }
    
    var numberOfItems: Int { get }
    func itemPresenter(at indexPath: IndexPath) -> EventCellPresenter
    func selectItem(at indexPath: IndexPath)
}

internal final class EventsListPresenterImpl: EventsListPresenter {
    let title = NSLocalizedString("Events", comment: "")
    var onUpdate: (() -> Void)? {
        didSet { onUpdate?() }
    }
    
    private let interactor: EventsInteractor
    private var events: [Event] = []

    init(interactor: EventsInteractor) {
        self.interactor = interactor
    }
        
    func load() {
        interactor.getAllEvents().onSuccess { [weak self] events in
            self?.events = events
            self?.onUpdate?()
        }
    }
    
    var numberOfItems: Int {
        return events.count
    }
    
    func itemPresenter(at indexPath: IndexPath) -> EventCellPresenter {
        let event = events[indexPath.item]
        return EventCellPresenterImpl(event: event)
    }
    
    func selectItem(at indexPath: IndexPath) {
        
    }
}
