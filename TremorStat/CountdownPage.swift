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
    let MyLabel: UILabel = UILabel(frame:CGRect(x: 50, y: 50, width: 320, height:50))
    
    func Clock(){
        seconds=seconds-1
        MyLabel.text=String(seconds)
        if(seconds==0){
            MyLabel.backgroundColor=UIColor(red:0xff, green:0x00, blue:0x00, alpha:1)
            MyLabel.text="Test Begins"
            timer.invalidate()
            performSegue(withIdentifier: "RestTremor", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountdownPage.Clock), userInfo: nil, repeats: true)
        MyLabel.font=UIFont.init(name:"ariel",size: 100)
        MyLabel.textAlignment = .center
        MyLabel.textColor=UIColor(red:0xff, green:0xff, blue:0xff, alpha:1)
        MyLabel.backgroundColor=UIColor(red:0x00, green:0xff, blue:0x00, alpha:1)
        self.view.addSubview(MyLabel)
        
        // Do any additional setup after loading the view.
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

