//
//  MemberWireframe.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal protocol MemberViewDelegate: class {

}

internal struct MemberWireframe {
    static func viewController(withDelegate delegate: MemberViewDelegate) -> UIViewController {
        let presenter = MemberPresenterImpl()
        let vc = MemberViewController(presenter: presenter)

        /*

            presenter.onSelect = { [weak delegate, unowned vc] data in
                delegate?.view(vc, didFinishWith: data)
            }

        */
        return vc
    }
}
