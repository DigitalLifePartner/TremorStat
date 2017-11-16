//  File Information:
//  CGContext
//
//  Licensing:
//  Copyright (C) 2016 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information.
//
//  Modified by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Extention for CGContext that allows lines to be drawn
//  on a graph

import UIKit

extension CGContext {
    func drawGraphLines(in size: CGSize) {
        // Configure context settings.
        self.saveGState()
        setShouldAntialias(false)
        translateBy(x: 0, y: size.height / 2.0)
        
        // Add lines to the context.
        let gridLineSpacing = size.height / 8.0
        for index in -3...3 {
            // Skip the center line.
            guard index != 0 else { continue }
            
            let position = floor(gridLineSpacing * CGFloat(index))
            move(to: CGPoint(x: 0, y: position))
            addLine(to: CGPoint(x: size.width, y: position))
        }
        
        // Stroke the lines.
        setStrokeColor(UIColor.darkGray.cgColor)
        strokePath()
        
        // Add and stroke the center line.
        move(to: CGPoint(x: 0, y: 0))
        addLine(to: CGPoint(x: size.width, y: 0))
        
        setStrokeColor(UIColor.lightGray.cgColor)
        strokePath()
        
        // Restore the context state.
        self.restoreGState()
    }
}
