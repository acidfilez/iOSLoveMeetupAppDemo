//
//  MembersInteractor.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/29/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation
import BrightFutures

internal enum MembersInteractorError: Error {
    case unableToGetAllMembers(Error)
}

internal protocol GetMembersInteractor {
    func getAllMembers() -> Future<[Member], MembersInteractorError>
    func getRSVPMembers(for event: Event) -> Future<[Member], MembersInteractorError>
}

internal final class MembersInteractorImpl {
    private let dataManager: ModelDataManager
    
    init(dataManager: ModelDataManager) {
        self.dataManager = dataManager
    }
}

extension MembersInteractorImpl: GetMembersInteractor {
    func getAllMembers() -> Future<[Member], MembersInteractorError> {
        return dataManager
            .getAllMembers()
            .mapError { MembersInteractorError.unableToGetAllMembers($0) }
    }
    
    func getRSVPMembers(for event: Event) -> Future<[Member], MembersInteractorError> {
        return dataManager
            .getRSVPMembers(forEventId: event.id)
            .mapError { MembersInteractorError.unableToGetAllMembers($0) }
    }
    
    // TODO: Add Search member by name in HERE (That would add some more logic)
}
