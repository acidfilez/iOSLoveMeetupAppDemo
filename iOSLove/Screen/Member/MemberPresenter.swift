//
//  MemberPresenter.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import Foundation

internal protocol MemberPresenter: class {
    var numberOfItems: Int { get }
    func itemPresenter(at indexPath: IndexPath) -> MemberCellPresenter
    func selectItem(at indexPath: IndexPath)
}

internal final class MemberPresenterImpl {

}

extension MemberPresenterImpl: MemberPresenter {
    var numberOfItems: Int {
        return 10 //TODO: Return the number of items
    }

    func itemPresenter(at indexPath: IndexPath) -> MemberCellPresenter {
        return MemberCellPresenterImpl()
    }

    func selectItem(at indexPath: IndexPath) {
        //TODO: Handle selected item
    }
}
