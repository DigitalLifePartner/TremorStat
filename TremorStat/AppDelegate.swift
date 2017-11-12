//  AppDelegate
//
//  Licensing:
//  Copyright (C) 2016 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information.
//
//  Modified by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  UIViewController delegate

import UIKit
import CoreMotion


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    var window: UIWindow?
    
    let motionManager = CMMotionManager()
    
    // MARK: Implementation

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Enumerate through the view controller hierarchy, setting the `motionManager`
        // property on those that conform to the `MotionGraphContainer` protocol.
        window?.rootViewController?.enumerateHierarchy { viewController in
            guard var container = viewController as? MotionGraphContainer else { return }
            container.motionManager = motionManager
        }
        
        return true
    }
}
