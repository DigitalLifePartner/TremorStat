//  File Information:
//  ActionTremorResultsDescription
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of a particular action tremor test

import UIKit

class ActionTremorResultsDescription: UIViewController {
    
    // Lable declaration for various test parameters
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var devianceLabel: UILabel!
    @IBOutlet weak var tapsNumLabel: UILabel!
    // Array storing result of the test
    var results = [[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Print test results when view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // Code below transforms a Date type in a readable format
        var dateString = Date(timeIntervalSince1970:(results[AT_TIME][0]))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let mystring = dateFormatter.string(from: dateString);
        let yourDate: Date? = dateFormatter.date(from: mystring)
        dateFormatter.dateFormat = "MMM-dd-yyyy - h:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        
        // Print an date of the test in the appropriate labels
        let updatedDateString = dateFormatter.string(from: yourDate!)
        dateLabel.text = updatedDateString;
        
        // Print frequency, deviance and number of taps in appropriate labels
        frequencyLabel.text = String(Double(round(10000*results[AT_FREQUENCY][0])/10000))
        devianceLabel.text = String(Double(round(10000*results[AT_DEVIANCE][0])/10000))
        tapsNumLabel.text = String(Int(results[AT_NUMTAPS][0]))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
