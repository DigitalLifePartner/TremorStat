//  File Information:
//  RestTremorResultsDescription
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of a particular rest tremor test

import UIKit

class RestTremorResultsDescription: UIViewController {
    
    // Lable declaration for various test parameters
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var xOffsetLabel: UILabel!
    @IBOutlet weak var yOffsetLabel: UILabel!
    @IBOutlet weak var zOffsetLabel: UILabel!
    
    @IBOutlet weak var xDeviationLabel: UILabel!
    @IBOutlet weak var yDeviationLabel: UILabel!
    @IBOutlet weak var zDeviationLabel: UILabel!
    
    @IBOutlet weak var amountWithinAverageLabel: UILabel!
    // Array storing result of the test
    var results = [[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Print test results when view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        
        // Code below transforms a Date type in a readable format
        var dateString = Date(timeIntervalSince1970:(results[RT_TIME][0]))
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
        
        // Print x,y,z offsets in appropriate labels
        xOffsetLabel.text = String(Double(round(10000*results[RT_XAVERAGE][0])/10000))
        yOffsetLabel.text = String(Double(round(10000*results[RT_YAVERAGE][0])/10000))
        zOffsetLabel.text = String(Double(round(10000*results[RT_ZAVERAGE][0])/10000))
        
        // Print x,y,z deviations in appropriate labels
        xDeviationLabel.text = String(Double(round(10000*results[RT_XSTDEV][0])/10000))
        yDeviationLabel.text = String(Double(round(10000*results[RT_YSTDEV][0])/10000))
        zDeviationLabel.text = String(Double(round(10000*results[RT_ZSTDEV][0])/10000))
        
        // find out how many of the users results are within the average range
        var statCalc = StatisticsCalculator()
        
        var inAverageRange = [Double]()
        // construct total average array
        /*for i in 0...( READINGS_PER_TEST - 1 ) {
            inAverageRange[i] = (results[RT_TIME][i])
        }*/
        //let inAverageRange = statCalc.searchAndMakeWithinInterval( theArray: results[RT_XAVERAGE], leftMostVal: 0.0, rightMostVal: AVG_PERSON_PLUS_STDDEV )
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

