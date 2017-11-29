//  File Information:
//  AccelerometerView
//
//  Licensing:
//  Copyright (C) 2016 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information.
//
//  Modified by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  A view controller to display output from the accelerometer.

import UIKit
import CoreMotion
import simd

class AccelerometerView: UIViewController, MotionGraphContainer {
    
    // MARK: Properties
    
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var updateIntervalLabel: UILabel!
    
    @IBOutlet weak var updateIntervalSlider: UISlider!
    
    @IBOutlet var valueLabels: [UILabel]!

    var motionManager: CMMotionManager?
    
    let updateIntervalFormatter = MeasurementFormatter()
    
    // MARK: Overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopUpdates()
    }
    
    // MARK: IB actions
    
    @IBAction func intervalSliderChanged(_ sender: UISlider) {
        startUpdates()
    }
    
    // MARK: Implementation
    
    func startUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        
        //updateIntervalLabel.text = formattedUpdateInterval
        
        motionManager.accelerometerUpdateInterval = TimeInterval(updateIntervalSlider.value)
        motionManager.showsDeviceMovementDisplay = true
        
        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
            guard let accelerometerData = accelerometerData else { return }
            
            let acceleration: double3 = [accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z]
            self.graphView.add(acceleration)
            self.setValueLabels(xyz: acceleration)
        }
    }
    
    func stopUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        
        motionManager.stopAccelerometerUpdates()
    }
}

