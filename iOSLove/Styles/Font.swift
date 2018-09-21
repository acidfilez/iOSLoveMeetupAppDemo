//
//  Font.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal enum Font: String {
    case light = "AvenirNext-Regular"
    case regular = "AvenirNext-Medium"
    case medium = "AvenirNext-DemiBold"
    case bold = "AvenirNext-Bold"
    
    func size(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)! // FORCE UNWRAP ALL THE THINGS
    }
}
