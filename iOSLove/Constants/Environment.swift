//
//  Environment.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/28/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal enum Environment {
    case staging
    case production
    
    // TODO: Check current enviroment with #if DEBUG
    static let current: Environment = .staging
}

internal extension Environment {
    /**
     The API Key it's saved in the scheme as Environment variable since is not shared (Unless you share it lol)
     */
    static var meetupAPIKey: String {
        switch Environment.current {
        case .staging, .production:
            return ProcessInfo.processInfo.environment["MEETUP_API_KEY"] ?? "unknown"
        }
    }
}
