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
    
    // set the default countdown to 5 seconds
    var seconds=5
    
    // var used to track if the clock is running or not
    var notRunning = false
    
    //Timer Label
    @IBOutlet weak var MyLabel: UILabel!
    
    //Tap number label
    @IBOutlet weak var TapsNumberLabel: UILabel!
    
    //Average Tap Number Label
    @IBOutlet weak var AvTapTime: UILabel!
    

    //Number of successful tap pairs
    var tapsNumber = 0
    
    //Sequence recognition variable
    var tapSide = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer()
        seconds = 30
        
        // start countdown
        self.startCountdown()
    }
    
    //Detect left button click
    @IBAction func LeftClick(_ sender: Any) {
        var oldTapSide=self.tapSide
        tapSide=false
        if (oldTapSide != self.tapSide){
            self.tapsNumber+=1
            self.TapsNumberLabel.text=String(self.tapsNumber)
        }
    }
    
    //Detect right button click
    @IBAction func RightClick(_ sender: Any) {
        var oldTapSide=self.tapSide
        tapSide=true
        if (oldTapSide != self.tapSide){
            self.tapsNumber+=1
            self.TapsNumberLabel.text=String(self.tapsNumber)
        }
    }
    
    func startCountdown(){
        // start timer and countdown
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountdownViewController.Clock), userInfo: nil, repeats: true)
        
        // make sure text is centered
        MyLabel.textAlignment = .center
        //self.view.addSubview(MyLabel)
    }
    
    @objc func Clock(){
        // if the seconds remaining is above zero, decrement
        if tapsNumber != 0{
            AvTapTime.text=String(Double(30-seconds)/Double(tapsNumber))
        }
        if seconds>0 {
            seconds=seconds-1
        }
        // display new time remaining
        MyLabel.text=String(seconds)
        
        // once the countdown has finished stop the timer and segue onto the rest tremor test
        if(seconds<=0 && notRunning == false){
            timer.invalidate()
            notRunning = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
