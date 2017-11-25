//
//  RestTremorUserProfile.swift
//  TremorStat
//
//  Created by Domenico Di Giovanni on 11/24/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit

let THIRTY_DAYS = 30
class RestTremorUserProfile: UIViewController {

    let YEAR = 2
    let MONTH = 1
    let DAY = 0
    //                  DAY / MONTH / YEAR
    var calendarDate = [ "0", "0", "0" ]
    
    var xValuesString = [String]()
    var XValuesInt = [Int]()
    
    var yValues: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCalendarDate( enteredDate: String )
    {
        
        // get the day from the date string
        var start = enteredDate.index( enteredDate.startIndex, offsetBy:8 )
        var end = enteredDate.index( enteredDate.startIndex, offsetBy: 10 )
        var range = start..<end
        calendarDate[DAY] = enteredDate.substring( with: range )
        
        // get the month
        start = enteredDate.index( enteredDate.startIndex, offsetBy:5 )
        end = enteredDate.index( enteredDate.startIndex, offsetBy: 7 )
        range = start..<end
        calendarDate[MONTH] = enteredDate.substring( with: range )
        
        // get the year
        start = enteredDate.index( enteredDate.startIndex, offsetBy:0 )
        end = enteredDate.index( enteredDate.startIndex, offsetBy: 4 )
        range = start..<end
        calendarDate[YEAR] = enteredDate.substring( with: range )
    }
    func constructXValueStrings( xValStart: Int ) {
        
        var currentDateTotal = Date()
        setCalendarDate(enteredDate: currentDateTotal.description )
        dayLabel.text = String(calendarDate[DAY])
        monthLabel.text = String(calendarDate[MONTH])
        yearLabel.text = String(calendarDate[YEAR])
        
        // will display last 30 days of tests ( or all tests if less than 30 days have passed )
        // note that days without tests will be omitted
        
        var dateString = String(calendarDate[DAY] + "/" + calendarDate[MONTH] + "/" + calendarDate[YEAR] + "/")
        xValuesString.insert( dateString, at: 0  )
        // if there were multiple tests in a day, average out their amplitude averages for the graph ( one data point per day )
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
        // display last thirty tests
        var xValuesStart = restTremorResultArray.count - THIRTY_DAYS
        
        // if there are fewer than 30 tests display up to that amount
        if ( xValuesStart < 0 ) {
            xValuesStart = 0
        }
        
        constructXValueStrings( xValStart: xValuesStart )
        
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
