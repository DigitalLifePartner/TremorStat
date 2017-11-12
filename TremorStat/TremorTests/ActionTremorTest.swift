//
//  ActionTremorTest.swift
//  TremorStat
//
//  Created by ikukushk on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class ActionTremorTest: UIViewController {
    
    // MARK: Properties
    
    // set up a timer
    var timer = Timer()
    
    // set the default countdown to 30 seconds
    var seconds=30.0
    
    // variable that stors last pair tapped timing
    var lastTapTiming = 30.0
    
    // var used to track if the clock is running or not
    var notRunning = false
    
    //Timer Label
    @IBOutlet weak var MyLabel: UILabel!
    
    //Tap number label
    @IBOutlet weak var TapsNumberLabel: UILabel!
    
    //Average Tap Number Label
    @IBOutlet weak var AvTapTime: UILabel!
    
    //Average Tap Number Label (Dom's olution)
    @IBOutlet weak var DomTapTime: UILabel!
    
    //Number of successful tap pairs
    var tapsNumber = 0
    
    //Sequence recognition variable
    var tapSide = true
    
    //Array of paired taps timings
    var pairedTiming = [Double]()
    
    //Instantiating Statistics class for data representation
    var statisticsCalculator = StatisticsCalculator()
    
    // MARK: ViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start 30s countdown
        timer = Timer()
        self.startCountdown()
    }
    
    // MARK: Button click actions
    //Detect left button click
    @IBAction func LeftClick(_ sender: Any) {
        var oldTapSide=self.tapSide
        tapSide=false
        if (oldTapSide != self.tapSide){
            lastTapTiming=seconds
            self.tapsNumber+=1
            self.TapsNumberLabel.text=String(self.tapsNumber)
            pairedTiming.append(lastTapTiming-seconds)
            lastTapTiming=seconds
        }
    }
    
    //Detect right button click
    @IBAction func RightClick(_ sender: Any) {
        var oldTapSide=self.tapSide
        tapSide=true
        if (oldTapSide != self.tapSide){
            self.tapsNumber+=1
            self.TapsNumberLabel.text=String(self.tapsNumber)
            pairedTiming.append(lastTapTiming-seconds)
            lastTapTiming=seconds
        }
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
    
    @objc func Clock(){
        // if the seconds remaining is above zero, decrement
        if tapsNumber != 0{
            AvTapTime.text=String(Double(100000*(30-Int(seconds))/(tapsNumber))/100000)
        }
        if seconds>0 {
            seconds=seconds-0.1
        }
        // display new time remaining
        MyLabel?.text=String(Int(seconds))
        
        // once the countdown has finished stop the timer and segue onto the rest tremor test
        if(seconds<=0 && notRunning == false){
            timer.invalidate()
            notRunning = true
            performSegue(withIdentifier: "ActionApprovePage", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
