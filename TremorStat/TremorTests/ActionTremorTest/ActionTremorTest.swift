//
//  ActionTremorTest.swift
//  TremorStat
//
//  Created by ikukushk on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

var actionTremorResultArray = [ActionTremorResultsClass]()
//Array of taps timings
var tapTimes = [Double]()
var deviances = [Double]()
var avgTime = 0.0
var avgDeviance = 0.0

//Unsigned int to track number of taps
var numTaps = 0

class ActionTremorTest: UIViewController {
    
    @IBOutlet weak var ActionTremorButton: UIView!
    
    
    // MARK: Properties
    //VERONICA: Who's Mark?
    
    //Constants and Variables//////////////////////
    
    // set up a timer
    var timer = Timer()
    
    //Note that if you change test length you have to change both variables, due to Swift being a piece of shit. It wont let me just set the variable equal to the constant
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
        
        //Set time of last tap to current time
        lastTapTime = currentTime
        
    }
    
    @IBAction func ExitButtonAction(_ sender: Any) {
        timer.invalidate()
    }
    
    
    // MARK: 30 sec timer Implementation
    func startCountdown(){
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
        
            var results = ActionTremorResultsClass()
            //results.pairedTiming = self.pairedTiming
            results.frequency = avgTime
            results.deviance = avgDeviance
            
            //results.stdDev = statisticsCalculator.calcStdDev(theData: pairedTiming, theSize: pairedTiming.count, gotMean: false, absolute: false)
            actionTremorResultArray.append( results )
            performSegue(withIdentifier: "ApprovePage", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
