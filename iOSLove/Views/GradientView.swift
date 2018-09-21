//
//  GradientView.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

@IBDesignable internal final class GradientView: UIView {
    @IBInspectable var fromColor: UIColor = UIColor.black {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var toColor: UIColor = UIColor.white {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var isLinear: Bool = true {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var radius: CGFloat = 1 {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let space = CGColorSpaceCreateDeviceRGB()
        let colors = [fromColor.cgColor, toColor.cgColor] as CFArray
        
        guard let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil) else { return }
        
        let options: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        
        if isLinear {
            let start = CGPoint(x: rect.minX + startPoint.x * rect.width,
                                y: rect.minY + startPoint.y * rect.height)
            
            let end = CGPoint(x: rect.minX + endPoint.x * rect.width,
                              y: rect.minY + endPoint.y * rect.height)
            
            context.drawLinearGradient(gradient, start: start, end: end, options: options)
        } else {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let endRadius = min(rect.width, rect.height)/2 * radius
            
            context.drawRadialGradient(gradient,
                                       startCenter: center,
                                       startRadius: 0,
                                       endCenter: center,
                                       endRadius: endRadius,
                                       options: options)
        }
    }
}

