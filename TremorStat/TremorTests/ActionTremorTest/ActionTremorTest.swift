//
//  ActionTremorTest.swift
//  TremorStat
//
//  Created by ikukushk on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

//Array of taps timings
var tapTimes = [Double]()
var deviances = [Double]()
var avgTime = 0.0
var avgDeviance = 0.0


// Indeces constants to access particular elements of the test
let AT_TIME = 0
let AT_FREQUENCY = 1
let AT_DEVIANCE = 2
let AT_NUMTAPS = 3
let AT_TAPS = 4
let AT_MED = 5
let AT_SUP = 6

// variable that transforms currentTime to an appropriate format
var timeReverser = 0.0

//Unsigned int to track number of taps
var numTaps = 0

class ActionTremorTest: UIViewController {
    
    // Array containing all Action Tremor Test results
    var actionTremorResultArray = [[[Double]]]()
    
    // Array containing times at which taps have occured
    var tapsArray = [Double]()
    
    @IBOutlet weak var ActionTremorButton: UIView!
    
    // MARK: Properties
    
    //Constants and Variables
    
    // set up a timer
    var timer = Timer()
    
    //Double to keep track of previous tap
    var lastTapTime = 15.0
    
    //Double to track current time
    //If you change testLength make sure to change this as well
    var currentTime = 15.0
    
    // var used to track if the clock is running or not
    var notRunning = false
    
    //Timer Label
    @IBOutlet weak var MyLabel: UILabel!
    
    //Tap number label
    @IBOutlet weak var TapsNumberLabel: UILabel!
    
    //Average Tap Number Label
    @IBOutlet weak var AvTapTime: UILabel!
    
    //Instantiating Statistics class for data representation
    var statisticsCalculator = StatisticsCalculator()
    
    // MARK: ViewController overrides
    override func viewDidLoad() {
        
        //Store previous Action Tremor Test results in the array
        self.actionTremorResultArray = getDataFromKey(key: "actionTremorResultArray")
        
        super.viewDidLoad()
        
        //Make button slightly less crappy looking
        ActionTremorButton.layer.cornerRadius = 25
        
        // start 30s countdown
        timer = Timer()
        self.startCountdown()
    }
    
    override func viewDidDisappear(_ animated: Bool){
    }
    
    // MARK: Button click actions
    
    @IBAction func ButtonTap(_ sender: Any) {
        
        numTaps += 1
        
        if (numTaps > 1){
            //Push the time elapsed since last tap
            tapTimes.append(lastTapTime - currentTime)
        }
        
        tapsArray.append(timeReverser)
        //Set time of last tap to current time
        lastTapTime = currentTime
        
    }
    
    @IBAction func ExitButtonAction(_ sender: Any) {
        timer.invalidate()
    }
    
    
    // MARK: 30 sec timer Implementation
    func startCountdown(){
        numTaps = 0
        // start timer and countdown
        timer=Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ActionTremorTest.Clock), userInfo: nil, repeats: true)
        
        // make sure text is centered
        MyLabel?.textAlignment = .center
        //self.view.addSubview(MyLabel)
    }
    
    @objc func Clock()
    {
        // if the seconds remaining is above zero, decrement
        if currentTime>0 {
            currentTime -= 0.1
            timeReverser += 0.1
        }
        // display new time remaining
        MyLabel?.text=String(Int(currentTime))
        
        // once the countdown has finished stop the timer and segue onto the rest tremor test
        if(currentTime <= 0 && notRunning == false)
        {
            timer.invalidate()
            notRunning = true
            
            for time in tapTimes{
                //Summing tapTimes
                avgTime += (time)
            }
            
            //Calculate average tap time
            avgTime /= Double(numTaps - 1)
            
            for time in tapTimes{
                //Summing tapTimes
                deviances.append(abs(avgTime - (time)))
            }
            
            for deviance in deviances{
                avgDeviance += (deviance)
            }
            
            avgDeviance /= Double(numTaps - 1)
            
            //Convert to Frequency (Hz)
            avgTime = 1.0/avgTime
            
            if numTaps == 0
            {
                avgTime = 0.0;
                avgDeviance = 0.0
            }
        
            var results = Array(repeating: [0.0], count: 7)
            results[AT_TIME]=[Double(Date().timeIntervalSince1970)]
            results[AT_FREQUENCY]=[avgTime]
            results[AT_DEVIANCE]=[avgDeviance]
            results[AT_NUMTAPS]=[Double(numTaps)]
            results[AT_TAPS]=tapsArray
            results[AT_MED]=getDoubleDrugArray()[0]
            results[AT_SUP]=getDoubleDrugArray()[1]
            
            actionTremorResultArray.append( results )
            //Store test results under associated key
            UserDefaults.standard.set(actionTremorResultArray, forKey: "actionTremorResultArray")
            performSegue(withIdentifier: "ApprovePage", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
