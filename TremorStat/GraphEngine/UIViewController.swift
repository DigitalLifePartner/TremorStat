//  File Information:
//  UIViewController
//
//  Licensing:
//  Copyright (C) 2016 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information.
//
//  Modified by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Extends `UIViewController` to add a method to enumerate
//  through a view controller heirarchy

import UIKit

extension UIViewController {
    /// Executes the specified closure for each of the child and descendant view
    /// controller, as well as for the view controller itself.
    func enumerateHierarchy(_ closure: (UIViewController) -> Void) {
        closure(self)
        
        for child in childViewControllers {
            child.enumerateHierarchy(closure)
        }
        
    }
}
