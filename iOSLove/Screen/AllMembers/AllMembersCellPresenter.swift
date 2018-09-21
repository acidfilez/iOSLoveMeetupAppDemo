//
//  MemberCellPresenter.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal protocol AllMembersCellPresenter: class {
    var name: String { get }
    var thumbURL: URL? { get }
}

internal final class AllMembersCellPresenterImpl {
    private let member: Member
    
    init(member: Member) {
        self.member = member
    }
}

extension AllMembersCellPresenterImpl: AllMembersCellPresenter {
    var name: String {
        return member.name
    }
    
    var thumbURL: URL? {
        return member.photo?.thumb_link
    }
}
