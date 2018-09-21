//
//  Stylable.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal struct Style<Element> {
    fileprivate let applyTo: (Element) -> Void
    
    init(applyTo: @escaping (Element) -> Void) {
        self.applyTo = applyTo
    }
}

internal protocol Stylable: class {
    associatedtype Element
    func apply(styles: Style<Element>... )
}

extension Stylable where Self: Stylable {
    func apply(styles: Style<Self>... ) {
        styles.forEach { $0.applyTo(self) }
    }
}

extension UIView: Stylable { }
