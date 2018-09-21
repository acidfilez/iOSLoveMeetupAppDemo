//
//  Member.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/28/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal struct Member: Codable {
    let id: UInt64
    let name: String
    let bio: String?
    let photo: Member.Photo?
    
    internal struct Photo: Codable {
        let thumb_link: URL
    }
    
    init(id: UInt64, name: String, bio: String?, photo: Member.Photo?) {
        self.id = id
        self.name = name
        self.bio = bio
        self.photo = photo
    }
}
