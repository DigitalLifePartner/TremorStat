//
//  ActionTremorResultsDescription.swift
//  TremorStat
//
//  Created by Milos Savic on 11/18/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

class ActionTremorResultsDescription: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var devianceLabel: UILabel!
    @IBOutlet weak var tapsNumLabel: UILabel!
    
    
    var results = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        var dateString = Date(timeIntervalSince1970:(results[0]))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let mystring = dateFormatter.string(from: dateString);
        let yourDate: Date? = dateFormatter.date(from: mystring)
        dateFormatter.dateFormat = "MMM-dd-yyyy - h:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        let updatedDateString = dateFormatter.string(from: yourDate!)
        
        dateLabel.text = updatedDateString;
        
        
        //var dateString = NSDate(timeIntervalSince1970:(results[0]))
        //dateLabel.text = String(describing: dateString)
        frequencyLabel.text = String(Double(round(10000*results[1])/10000))
        devianceLabel.text = String(Double(round(10000*results[2])/10000))
        tapsNumLabel.text = String(Int(results[3]))
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
