//
//  MeetupAPIClient.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/28/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation
import BrightFutures

internal enum MeetupAPIError: Error {
    case unableToGetMemebers(Error)
    case unableToGetEvents(Error)
    case unableToGetRSVPS(Error)
}

internal protocol MeetupAPIClient {
    func getMemebers() -> Future<[Member], MeetupAPIError>
    func getEvents() -> Future<[Event], MeetupAPIError>
    func getRVPS(forEventId eventId: String) -> Future<[Member], MeetupAPIError>
}

internal func MeetupAPIClientDefault() -> MeetupAPIClient {
    return MeetupAPIClientImpl(key: Environment.meetupAPIKey)
}

private final class MeetupAPIClientImpl {
    private struct Constants {
        static let groupId = "3602432"
        static let pageSize = "200"
    }

    private enum Route: String, APIClientRoute {
        static let baseURL = "http://api.meetup.com"
        case members = "/2/members"
        case events = "/2/events"
        case rsvps = "/2/rsvps"
        
        var url: URL {
            return URL(string: Route.baseURL + self.rawValue)!
        }
    }
    
    private struct ResultsArray<T: Codable>: Codable {
        let results: [T]
    }
    
    private let key: String
    private let apiClient: APIClient = APIClientDefault()
    
    init(key: String) {
        self.key = key
    }
    
    private func defaultParameters(adding parameters: [String: Any]) -> [String: Any] {
        var mergedParams: [String: Any] = [
            "key": key,
            "group_id": Constants.groupId,
            "page": Constants.pageSize
        ]
        
        parameters.forEach { mergedParams[$0] = $1 }
        return mergedParams
    }
}

extension MeetupAPIClientImpl: MeetupAPIClient {
    
    func getMemebers() -> Future<[Member], MeetupAPIError>  {
        /**
         page= indicate the page size (max 200)
         offset= page number (skips X times the page size)
         TODO: I would need to perform at least 3 requests to this one...
         */
        let params = defaultParameters(adding: [
            "only": "id,name,photo.thumb_link,bio"
            ]
        )
        return apiClient.request(route: Route.members, method: .GET, parameters: params)
            .mapError { MeetupAPIError.unableToGetMemebers($0) }
            .map { (response: ResultsArray<Member>) in
                return response.results
        }
    }
    
    func getEvents() -> Future<[Event], MeetupAPIError> {
        let params = defaultParameters(adding: [
            "status": "upcoming,past",
            "order": "time",
            "desc": "true",
            "only": "id,name,venue.name,status,time,description,photo_url"
            ]
        )
        return apiClient.request(route: Route.events, method: .GET, parameters: params)
            .mapError { MeetupAPIError.unableToGetRSVPS($0) }
            .map { (response: ResultsArray<Event>) in
                return response.results
        }
    }
    
    func getRVPS(forEventId eventId: String) -> Future<[Member], MeetupAPIError> {
        let params = defaultParameters(adding: [
            "event_id": eventId,
            "rsvp": "yes",
            "only": "member_photo.thumb_link,member"
            ]
        )
        
        // TODO: I know this is not the right way, and I should use the init(coder..)
        struct UglyMeetupMember: Codable {
            struct WhyMember: Codable {
                let member_id: UInt64
                let name: String
            }
            let member: WhyMember
            let member_photo: Member.Photo?
        }
        
        return apiClient.request(route: Route.rsvps, method: .GET, parameters: params)
            .mapError { MeetupAPIError.unableToGetEvents($0) }
            .map { (response: ResultsArray<UglyMeetupMember>) in response.results }
            .map { uglyMembers in
                uglyMembers.map {
                    Member(id: $0.member.member_id, name: $0.member.name, bio: nil, photo: $0.member_photo)
                }
        }
    }
    
}
