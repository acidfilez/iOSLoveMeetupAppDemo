//
//  Styles.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

extension Style where Element: UIView {
    static var rounded: Style {
        return Style { view in
            view.layer.cornerRadius = 4
            view.layer.masksToBounds = true
        }
    }
}

extension Style where Element: UIImageView {
    static var thumbnail: Style {
        return Style { imageView in
            imageView.layer.cornerRadius = 32
            imageView.layer.masksToBounds = true
        }
    }
}

extension Style where Element: UILabel {
    static var cellTitle: Style {
        return Style { label in
            label.font = Font.regular.size(size: 16)
            label.textColor = Color.cellTitle
        }
    }
    
    static var cellSubtitle: Style {
        return Style { label in
            label.font = Font.light.size(size: 14)
            label.textColor = Color.cellTitle
        }
    }
    
    static var memberCellTitle: Style {
        return Style { label in
            label.font = Font.regular.size(size: 12)
            label.textColor = .white
        }
    }
}
