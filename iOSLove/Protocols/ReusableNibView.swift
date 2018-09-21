//
//  ReusableNibView.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
    static var defaultKind: String { get }
}

internal protocol NibLoadable: class {
    static var nib: UINib { get }
}

internal protocol ReusableNibView: NibLoadable, ReusableView { }

internal extension NibLoadable {
    private static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}

internal extension ReusableView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var defaultKind: String {
        return String(describing: self) + "Kind"
    }
}
