//  File Information:
//  RestTremorTestViewController
//
//  Licensing:
//  Copyright (C) 2016 Apple Inc. All Rights Reserved.
//  See LICENSE.txt for this sample’s licensing information.
//
//  Modified by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Handling the rest tremor test view controller: graphing the gryoscope data;
//  providing a countdown; UI interactivity

import UIKit
import CoreMotion
import simd

let TEST_DURATION = 30.0

let PERIOD_FOR_READINGS = 0.025
let READINGS_PER_TEST = Int(TEST_DURATION/PERIOD_FOR_READINGS)

// class to handle rest tremor test
class RestTremorTestViewController: UIViewController, MotionGraphContainer {
    
    // MARK: Properties
    
    // test duration = 30 seconds
    var timeLeft = TEST_DURATION

    
    var stopTest = false

    // index of arrays
    var testCount = 0
    
    var finishedTest = false
    
    var motionManager: CMMotionManager?
    
    // component arrays for X Y Z coordinates ( size = 1200 because 30 s / 0.025 s sampling )
    var gyroArrayX = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayY = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayZ = Array(repeating: 0.0, count: READINGS_PER_TEST)
    
    // essentially a var that contains 3 doubles -- to store X Y Z coordinates
    var rotationRate: double3!
    
    // standard labels ( updated during time countdowns for display )
    @IBOutlet weak var timeNotification: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    
    // graphview is the actual graph
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var updateIntervalLabel: UILabel!
    @IBOutlet weak var updateIntervalSlider: UISlider!

    @IBOutlet var valueLabels: [UILabel]!

    let updateIntervalFormatter = MeasurementFormatter()
    
    // MARK: Overrides
    
    // should any other segue happen during a test - stop the test
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // stop gyro updates
        self.stopUpdates()
        
        // specific case for segue into the test approval view
        if finishedTest == true {
            finishedTest = false
            
            // pass the component arrays to the approval view
            let nextController = segue.destination as! ApprovalViewController
            nextController.gyroArrayX = self.gyroArrayX
            nextController.gyroArrayY = self.gyroArrayY
            nextController.gyroArrayZ = self.gyroArrayZ
            
            // for debugging
            /*for i in 0...100{
             print(String(gyroArrayY[i]))
             if gyroArrayY[i]==0.0{
             print()
             print()
             print(i," th's Position")
             break
             }
             }*/
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // hide the navigation controls while the test is in progress
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
        // set the default label texts
        timeNotification.text = "Time Remaining:"
        timeRemaining.text = "30"
        stopTest = false
        
        // start getting the gryoscope readings
        startUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // stop getting the updates from the gyro
        self.stopUpdates()
        super.viewDidDisappear(animated)
    }
    
    // MARK: Implementation
    
    // only to be called when a test is complete ( no exits / cancels )
    func goToApprove() {
        // segue back to the test approval page
        print("Going To Approve")
        performSegue(withIdentifier: "ApprovePage", sender: self)
    }
    
    func startUpdates() {
        
        if stopTest == false {
            // set the motionmanager equal to this to prevent gryo availability issue
            motionManager = CMMotionManager()
            
            // check for gyro availability
            guard let motionManager = motionManager, motionManager.isGyroAvailable else { return }
            
            //updateIntervalLabel.text = formattedUpdateInterval
            
            // get the interval for gryo updates based on slider
            motionManager.gyroUpdateInterval = TimeInterval(PERIOD_FOR_READINGS) //updateIntervalSlider.value
            motionManager.showsDeviceMovementDisplay = true
            
            // start reading from gyro
            motionManager.startGyroUpdates(to: .main) { gyroData, error in
                guard let gyroData = gyroData else { return }
                
                // update time left in the test based on the interval from the slider
                self.timeLeft = self.timeLeft - TimeInterval(PERIOD_FOR_READINGS)
                self.timeRemaining.text = String(Int((self.timeLeft)))
                
                // get the rotation data
                self.rotationRate = [gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z]
                
                // add point onto the graph
                self.graphView.add(self.rotationRate)
                
                // store components into associated arrays
                self.gyroArrayX.insert(gyroData.rotationRate.x, at: self.testCount)
                self.gyroArrayY.insert(gyroData.rotationRate.y, at: self.testCount)
                self.gyroArrayZ.insert(gyroData.rotationRate.z, at: self.testCount)
                
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
    
    // stop gyro updates
    func stopUpdates() {
        
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }
        self.stopTest = false
        
        // stop getting gryo readings
        motionManager.stopGyroUpdates()
        print("Stopping Gyro")
    }
    
}

