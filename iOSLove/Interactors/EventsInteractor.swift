//
//  EventsInteractor.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation
import BrightFutures

internal enum EventsInteractorError: Error {
    case unableToGetAllEvents(Error)
}

internal protocol EventsInteractor {
    func getAllEvents() -> Future<[Event], EventsInteractorError>
}

internal final class EventsInteractorImpl {
    let dataManager: ModelDataManager
    
    init(dataManager: ModelDataManager) {
        self.dataManager = dataManager
    }
}

extension EventsInteractorImpl: EventsInteractor {
    func getAllEvents() -> Future<[Event], EventsInteractorError> {
        return dataManager.getAllEvents().mapError{ EventsInteractorError.unableToGetAllEvents($0) }
    }
}
