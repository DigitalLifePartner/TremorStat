//  File Information:
//  CountdownViewController
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Initiate a countdown to the rest tremor test and display said countdown

import UIKit

class ActionTremorCountdown: UIViewController {
    
    // MARK: Properties
    
    // set up a timer
    var timer = Timer()
    
    // set the default countdown to 5 seconds
    var seconds=5
    
    // var used to track if the clock is running or not
    var notRunning = false
    
    @IBOutlet weak var MyLabel: UILabel!
    
    // MARK: Overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide the navigation controls during the countdown so user cannot leave
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reinit vars incase of segue during countdown
        timer = Timer()
        seconds = 5
        
        // start countdown
        self.startCountdown()
        
        // Do any additional setup after loading the view.
    }
    
    // for when there was a segue during countdown - reset countdown
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer()
        seconds = 5
        if notRunning == true {
            notRunning = false
        }
    }
    
    // segue from this slide results in the resetting of the timer
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
        seconds = 5
        notRunning = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Implementation
    
    func startCountdown(){
        // start timer and countdown
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ActionTremorCountdown.Clock), userInfo: nil, repeats: true)
        
        // make sure text is centered
        MyLabel.textAlignment = .center
        self.view.addSubview(MyLabel)
    }
    
    @objc func Clock(){
        // if the seconds remaining is above zero, decrement
        if seconds>0 {
            seconds=seconds-1
        }
        // display new time remaining
        MyLabel.text=String(seconds)
        
        // once the countdown has finished stop the timer and segue onto the rest tremor test
        if(seconds<=0 && notRunning == false){
            MyLabel.text="Test Begins"
            timer.invalidate()
            notRunning = true
            performSegue(withIdentifier: "ActionTremor", sender: self)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


