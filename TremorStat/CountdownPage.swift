//
//  CountdownPage.swift
//  TremorStat
//
//  Created by Domenico Di Giovanni on 11/4/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class CountdownPage: UIViewController {
    
    var timer = Timer()
    var seconds=5
    //let MyLabel: UILabel = UILabel(frame:CGRect(x: 50, y: 50, width: 320, height:50))
    
    // var used to track if the clock is running or not
    var notRunning = false
    
    @IBOutlet weak var MyLabel: UILabel!
    
    func Clock(){
        //MyLabel.backgroundColor=UIColor(red:0x00, green:0xff, blue:0x00, alpha:1)
        if seconds>0 {
            seconds=seconds-1
        }
        MyLabel.text=String(seconds)
        if(seconds<=0 && notRunning == false){
            //MyLabel.backgroundColor=UIColor(red:0xff, green:0x00, blue:0x00, alpha:1)
            MyLabel.text="Test Begins"
            timer.invalidate()
            notRunning = true
            performSegue(withIdentifier: "RestTremor", sender: self)
        }
    }
    
    override func viewDidLoad() {
        
        
        // reinit vars incase of segue during countdown
        timer = Timer()
        seconds = 5
        super.viewDidLoad()
        
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
    
    // countdown
    func startCountdown(){
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountdownPage.Clock), userInfo: nil, repeats: true)
        //MyLabel.font=UIFont.init(name:"ariel",size: 200)
        MyLabel.textAlignment = .center
        //MyLabel.textColor=UIColor(red:0xff, green:0xff, blue:0xff, alpha:1)
        //MyLabel.backgroundColor=UIColor(red:0x00, green:0xff, blue:0x00, alpha:1)
        self.view.addSubview(MyLabel)
    }
    
    // segue from this slide results in the resetting of the timer
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        seconds = 5
        notRunning = true
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

