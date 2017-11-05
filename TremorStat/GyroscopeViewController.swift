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
        
        // segue back to a previous page
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
        
        // set the motionmanager equal to this to prevent gryo availability issue
        motionManager = CMMotionManager()
        
        // check for gyro availability
        guard let motionManager = motionManager, motionManager.isGyroAvailable else { return }
        
        updateIntervalLabel.text = formattedUpdateInterval
        
        // get the interval for gryo updates based on slider
        motionManager.gyroUpdateInterval = TimeInterval(updateIntervalSlider.value)
        motionManager.showsDeviceMovementDisplay = true
        
        // start reading from gyro
        motionManager.startGyroUpdates(to: .main) { gyroData, error in
            guard let gyroData = gyroData else { return }
            
            // update time left in the test based on the interval from the slider
            self.timeLeft = self.timeLeft - TimeInterval(self.updateIntervalSlider.value)
            self.timeRemaining.text = String(Int((self.timeLeft)))
            let rotationRate: double3 = [gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z]
            self.graphView.add(rotationRate)
            self.setValueLabels(xyz: rotationRate)
            
            // stop condition
            if self.timeLeft <= 0 {
                self.stopUpdates()
                self.goBackToMain()
            }
        }
    }
    
    // should any other segue happen during a test - stop the test
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.stopUpdates()
    }
    
    func stopUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        
        // stop getting gryo readings
        motionManager.stopGyroUpdates()
        print("Stopping Gyro")
    }
    
}

