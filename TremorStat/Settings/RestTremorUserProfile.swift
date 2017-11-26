//
//  RestTremorUserProfile.swift
//  TremorStat
//
//  Created by Best Software on 11/24/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

/*
 ABSTRACT:
 
 Purpose: Display average amplitude of users rest tremor test from the past 30 days of testing
 
 */

import UIKit

let THIRTY_DAYS = 30
class RestTremorUserProfile: UIViewController {

    // MARK: properties
    
    // indices indicating date
    let YEAR = 2
    let MONTH = 1
    let DAY = 0
    
    // amount of tests to display ( MAX )
    let DAYS_TESTED = 30
    
    //                  DAY / MONTH / YEAR
    var calendarDate = [ "0", "0", "0" ]
    
    // string that holds the date in string form
    var xValuesString = Array<Array<String>>()
    
    // hold date in double form ( DAY.MONTH )
    var XValues = [Double]()
    
    // value to plot against the date
    var yValues = [Double]()
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // display last thirty tests
        constructXValueStrings( )
        
    }
    
    // MARK: implementation
    
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
    func constructXValueStrings( ) {
        
        var currentDate = Date()
        setCalendarDate(enteredDate: currentDate.description )
        dayLabel.text = String(calendarDate[DAY])
        monthLabel.text = String(calendarDate[MONTH])
        yearLabel.text = String(calendarDate[YEAR])
        
        // will display last 30 days of tests ( or all tests if less than 30 days have passed )
        // note that days without tests will be omitted
        
        var amountOfTestedDays = 0
        var totalAverage = 0.0
        var multipleTestsAccountedFor = 0
        var sameDay = false
                        // day month
        var prevTest = [ "0", "0" ]
        while ( ( amountOfTestedDays < DAYS_TESTED ) && ( amountOfTestedDays + multipleTestsAccountedFor < restTremorResultArray.count ) ) {
            
            // get date from stored array
            currentDate = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ].testDate
            
            // split up into day / month / year
            setCalendarDate(enteredDate: currentDate.description)
            
            // check if this test occurred on the same day
            if ( calendarDate[DAY] == prevTest[0] && calendarDate[MONTH] == prevTest[1]) {
                
                // if it did the amount of days tested needs to be decremented as it is the same day
                amountOfTestedDays -= 1
                
                // instead we increment the multiple tests var to account for this
                multipleTestsAccountedFor += 1
                
                // force the sameDay bool to true
                sameDay = true
            }
            else { // different day
                sameDay = false
            }
            
            // add string array to larger array of dates
            
            // if it is a different day, add completely new entries to the xValue arrays
            if ( sameDay == false ) {
                xValuesString.insert(calendarDate, at: 0)
                
                // looks confusing, what I did was I took the day, and added it to the month divided by 100 so that November 15 ---> 11.15
                XValues.insert( Double( calendarDate[MONTH] )! + Double( calendarDate[DAY] )!/100.0, at: 0 )
            }
            
            // to avoid complications of the 3D array, take sum of the averages of the XYZ and display that instead
            totalAverage = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ].testAverageX + restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ].testAverageY + restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ].testAverageZ
            
            // add to the yValues
            if ( sameDay ) {
                // if it is the same day take average of two
                yValues[0] =  ( yValues[0] + totalAverage ) / 2.0
            }
            else {
                // add new entry to array
                yValues.insert( totalAverage, at: 0 )
            }
            
            // increment tested days
            amountOfTestedDays += 1
            
            // record last test date
            prevTest = [ calendarDate[DAY], calendarDate[MONTH] ]
            
        }
        //var dateString = String(calendarDate[DAY] + "/" + calendarDate[MONTH] + "/" + calendarDate[YEAR] + "/")
        //xValuesString.insert( dateString, at: 0  )
        // if there were multiple tests in a day, average out their amplitude averages for the graph ( one data point per day )
       
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
