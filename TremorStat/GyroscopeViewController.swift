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
    
    var timeLeft = 30.0
    
    var stopTest = false
    
    var testCount = 0
    
    var finishedTest = false
    
    var gyroArrayX = Array(repeating: 0.0, count: 1200)
    var gyroArrayY = Array(repeating: 0.0, count: 1200)
    var gyroArrayZ = Array(repeating: 0.0, count: 1200)
    
    // MARK: Properties
    @IBOutlet weak var timeNotification: UILabel!
    // MARK: Interface Builder actions
    
    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var graphView: GraphView!
    
    // MARK: MotionGraphContainer properties
    
    var motionManager: CMMotionManager?
    
    func goToApprove() {
        
        // segue back to a previous page
        print("Going To Approve")
        performSegue(withIdentifier: "ApprovePage", sender: self)
    }
    
    @IBOutlet weak var updateIntervalLabel: UILabel!
    
    @IBOutlet weak var updateIntervalSlider: UISlider!
    
    let updateIntervalFormatter = MeasurementFormatter()
    
    @IBOutlet var valueLabels: [UILabel]!
    
    // MARK: UIViewController overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
        timeNotification.text = "Time Remaining:"
        timeRemaining.text = "30"
        stopTest = false
        startUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stopUpdates()
        super.viewDidDisappear(animated)
    }
    
    var rotationRate: double3!
    
    @IBAction func intervalSliderChanged(_ sender: UISlider) {
        //startUpdates()
    }
    
    // MARK: MotionGraphContainer implementation
    
    func startUpdates() {
        
        if stopTest == false {
            // set the motionmanager equal to this to prevent gryo availability issue
            motionManager = CMMotionManager()
            
            // check for gyro availability
            guard let motionManager = motionManager, motionManager.isGyroAvailable else { return }
            
            //updateIntervalLabel.text = formattedUpdateInterval
            
            // get the interval for gryo updates based on slider
            motionManager.gyroUpdateInterval = TimeInterval(0.025) //updateIntervalSlider.value
            motionManager.showsDeviceMovementDisplay = true
            
            // start reading from gyro
            motionManager.startGyroUpdates(to: .main) { gyroData, error in
                guard let gyroData = gyroData else { return }
                
                // update time left in the test based on the interval from the slider
                self.timeLeft = self.timeLeft - TimeInterval(0.025)
                self.timeRemaining.text = String(Int((self.timeLeft)))
                self.rotationRate = [gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z]
                self.graphView.add(self.rotationRate)
                self.gyroArrayX.insert(gyroData.rotationRate.x, at: self.testCount)
                self.gyroArrayY.insert(gyroData.rotationRate.y, at: self.testCount)
                self.gyroArrayZ.insert(gyroData.rotationRate.z, at: self.testCount)
                
                //self.setValueLabels(xyz: rotationRate)
                
                // stop condition
                if self.timeLeft <= 0 {
                    self.finishedTest = true
                    self.stopTest = true
                    self.stopUpdates()
                    self.goToApprove()
                }
            }
        }
    }
    
    // should any other segue happen during a test - stop the test
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.stopUpdates()
        if finishedTest == true {
            finishedTest = false
            var nextController = segue.destination as! ApprovalPage
            nextController.gyroArrayX = self.gyroArrayX
            nextController.gyroArrayY = self.gyroArrayY
            nextController.gyroArrayZ = self.gyroArrayZ
        
            for i in 0...100{
                print(String(gyroArrayY[i]))
                if gyroArrayY[i]==0.0{
                    print()
                    print()
                    print(i," th's Position")
                    break
                }
        }
    }
    }
    
    func stopUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        self.stopTest = false
        // stop getting gryo readings
        motionManager.stopGyroUpdates()
        print("Stopping Gyro")
    }
    
}

