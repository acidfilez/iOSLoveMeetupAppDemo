//
//  ModelDataManager.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation
import BrightFutures

internal enum ModelDataManagerError: Error {
    case unableToFetchFromCache(Error)
    case unableToFetchFromAPI(Error)
}

internal protocol ModelDataManager {
    func getAllEvents() -> Future<[Event], ModelDataManagerError>
    func getAllMembers() -> Future<[Member], ModelDataManagerError>
    func getRSVPMembers(forEventId eventId: String) -> Future<[Member], ModelDataManagerError>
}

internal func ModelDataManagerDefault() -> ModelDataManager {
    return ModelDataManagerImpl()
}

private final class ModelDataManagerImpl {
    private lazy var meetupAPIClient = MeetupAPIClientDefault()
    private lazy var persistence = PersistenceDefault()
}

extension ModelDataManagerImpl: ModelDataManager {
    private struct Constants {
        static let eventsPersistenceKey = "meetup.events"
        static let membersAllPersistenceKey = "meetup.members"
        static func rsvpPersistenceKey(id: String) -> String { return "meetup.members." + id }
    }
    
    func getAllEvents() -> Future<[Event], ModelDataManagerError> {
        let key = Constants.eventsPersistenceKey
        do {
            let cachedEvents: [Event]? = try persistence.retrive(key: key)

            if let cachedEvents = cachedEvents {
                // TODO: For now we will just return any cached events without fetching
                return Future(value: cachedEvents)
            }
            
            return meetupAPIClient
                    .getEvents()
                    .mapError { ModelDataManagerError.unableToFetchFromAPI($0) }
                    .onSuccess { [weak self] events in
                        try? self?.persistence.store(data: events, key: key)
            }
            
        } catch {
            return Future(error: ModelDataManagerError.unableToFetchFromCache(error))
        }
    }
    
    func getAllMembers() -> Future<[Member], ModelDataManagerError> {
        let key = Constants.membersAllPersistenceKey
        do {
            let cachedMembers: [Member]? = try persistence.retrive(key: key)
            
            if let cachedMembers = cachedMembers {
                // TODO: For now we will just return any cached events without fetching
                return Future(value: cachedMembers)
            }
            
            // TODO: Add pagination in here to actually fetch all member (not just 200)
            return meetupAPIClient
                .getMemebers()
                .mapError { ModelDataManagerError.unableToFetchFromAPI($0) }
                .onSuccess { [weak self] members in
                    try? self?.persistence.store(data: members, key: key)
            }
        } catch {
            return Future(error: ModelDataManagerError.unableToFetchFromCache(error))
        }
    }
    
    func getRSVPMembers(forEventId eventId: String) -> Future<[Member], ModelDataManagerError> {
        let key = Constants.rsvpPersistenceKey(id: eventId)
        do {
            let cachedMembers: [Member]? = try persistence.retrive(key: key)
            
            if let cachedMembers = cachedMembers {
                // TODO: For now we will just return any cached events without fetching
                return Future(value: cachedMembers)
            }
            
            // TODO: Add pagination in here to actually fetch all member (not just 200)
            return meetupAPIClient
                .getRVPS(forEventId: eventId)
                .mapError { ModelDataManagerError.unableToFetchFromAPI($0) }
                .onSuccess { [weak self] members in
                    try? self?.persistence.store(data: members, key: key)
            }
        } catch {
            return Future(error: ModelDataManagerError.unableToFetchFromCache(error))
        }
    }
}
