//
//  AllMembersPresenter.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal protocol AllMembersPresenter: class {
    var title: String { get }
    func load()
    var onUpdate: (() -> Void)? { set get }
    
    var numberOfItems: Int { get }
    func itemPresenter(at indexPath: IndexPath) -> AllMembersCellPresenter
    func selectItem(at indexPath: IndexPath)
}

internal final class AllMembersPresenterImpl {
    let title = NSLocalizedString("Members", comment: "")

    var onUpdate: (() -> Void)? {
        didSet { onUpdate?() }
    }
    var onSelectItem: ((Member) -> Void)?

    private let interactor: GetMembersInteractor
    private var members: [Member] = []
    
    init(interactor: GetMembersInteractor) {
        self.interactor = interactor
    }
}

extension AllMembersPresenterImpl: AllMembersPresenter {
    func load() {
        interactor.getAllMembers().onSuccess { [weak self] members in
            self?.members = members
            self?.onUpdate?()
        }
    }

    var numberOfItems: Int {
        return members.count
    }

    func itemPresenter(at indexPath: IndexPath) -> AllMembersCellPresenter {
        let member = members[indexPath.item]
        return AllMembersCellPresenterImpl(member: member)
    }

    func selectItem(at indexPath: IndexPath) {
        let member = members[indexPath.item]
        onSelectItem?(member)
    }
}
