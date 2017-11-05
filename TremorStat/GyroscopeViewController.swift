/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A view controller to display output from the gyroscope.
 */

import UIKit
import CoreMotion
import simd

class GyroscopeViewController: UIViewController, MotionGraphContainer {
    
    var timeLeft = 3.0
    
    // MARK: Properties
    @IBOutlet weak var timeNotification: UILabel!
    // MARK: Interface Builder actions
    
    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var graphView: GraphView!
    
    // MARK: MotionGraphContainer properties
    
    var motionManager: CMMotionManager?
    
    func goBackToMain() {
        print("Going Back To Main")
        performSegue(withIdentifier: "ApprovePage", sender: self)
    }
    
    @IBOutlet weak var updateIntervalLabel: UILabel!
    
    @IBOutlet weak var updateIntervalSlider: UISlider!
    
    let updateIntervalFormatter = MeasurementFormatter()
    
    @IBOutlet var valueLabels: [UILabel]!
    
    // MARK: UIViewController overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeNotification.text = "Time Remaining:"
        timeRemaining.text = "30"
        startUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stopUpdates()
        super.viewDidDisappear(animated)
    }
    
    
    @IBAction func intervalSliderChanged(_ sender: UISlider) {
        //startUpdates()
    }
    
    // MARK: MotionGraphContainer implementation
    
    func startUpdates() {
        motionManager = CMMotionManager()
        guard let motionManager = motionManager, motionManager.isGyroAvailable else { return }
        
        updateIntervalLabel.text = formattedUpdateInterval
        
        motionManager.gyroUpdateInterval = TimeInterval(updateIntervalSlider.value)
        motionManager.showsDeviceMovementDisplay = true
        
        motionManager.startGyroUpdates(to: .main) { gyroData, error in
            guard let gyroData = gyroData else { return }
            self.timeLeft = self.timeLeft - TimeInterval(self.updateIntervalSlider.value)
            self.timeRemaining.text = String(Int((self.timeLeft)))
            let rotationRate: double3 = [gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z]
            self.graphView.add(rotationRate)
            self.setValueLabels(xyz: rotationRate)
            if self.timeLeft <= 0 {
                self.stopUpdates()
                self.goBackToMain()
            }
        }
    }
    
    func stopUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        motionManager.stopGyroUpdates()
        print("Stopping Gyro")
    }
    
}

