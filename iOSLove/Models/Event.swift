//
//  Event.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/28/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal struct Event: Codable {
    let id: String
    let name: String
    let time: TimeInterval
    let venue: Event.Venue
    let status: Event.Status
    
    enum Status: String, Codable {
        case upcoming
        case past
    }
    
    struct Venue: Codable {
        let name: String
    }
}
