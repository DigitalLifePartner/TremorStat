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
import Charts

let THIRTY_DAYS = 30
class RestTremorUserProfile: UIViewController {

    // MARK: properties
    
    @IBOutlet weak var restTremorChart: LineChartView!

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
    
    // MARK: overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restTremorChart.noDataText = "No Chart Data Available"
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
        
        // will display last 30 days of tests ( or all tests if less than 30 days have passed )
        // note that days without tests will be omitted
        
        var amountOfTestedDays = 0
        var totalAverage = 0.0
        var multipleTestsAccountedFor = 0
        var sameDay = false
        var restTremorResultArray = getDataFromKey(key: "restTremorResultArray")
        var currentRepeatedTests = 1
                        // day month
        var prevTest = [ "0", "0" ]
        var testDate = 0.0
        while ( ( amountOfTestedDays < DAYS_TESTED ) && ( amountOfTestedDays + multipleTestsAccountedFor < restTremorResultArray.count ) ) {
            
            // get date from stored array
            testDate = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ][RT_TIME][0]
            
            // split up into day / month / year
            setCalendarDate(enteredDate: String(testDate))
            
            // check if this test occurred on the same day
            if ( calendarDate[DAY] == prevTest[0] && calendarDate[MONTH] == prevTest[1]) {
                
                // if it did the amount of days tested needs to be decremented as it is the same day
                amountOfTestedDays -= 1
                
                // instead we increment the multiple tests var to account for this
                multipleTestsAccountedFor += 1
                
                currentRepeatedTests += 1
                
                // force the sameDay bool to true
                sameDay = true
            }
            else { // different day
                sameDay = false
                currentRepeatedTests = 1
            }
            
            // add string array to larger array of dates
            
            // if it is a different day, add completely new entries to the xValue arrays
            if ( sameDay == false ) {
                xValuesString.insert(calendarDate, at: 0)
                
                // looks confusing, what I did was I took the day, and added it to the month divided by 100 so that November 15 ---> 11.15
                XValues.insert( Double( calendarDate[MONTH] )! + Double( calendarDate[DAY] )!/100.0, at: 0 )
            }
            
            // to avoid complications of the 3D array, take sum of the averages of the XYZ and display that instead
            let xAverage = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ][RT_XAVERAGE][0]
            let yAverage = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ][RT_YAVERAGE][0]
            let zAverage = restTremorResultArray[ restTremorResultArray.count - 1 - amountOfTestedDays - multipleTestsAccountedFor ][RT_ZAVERAGE][0]
            
            totalAverage = xAverage + yAverage + zAverage
            
            // add to the yValues
            if ( sameDay ) {
                // if it is the same day take average of two
                yValues[0] =  ( yValues[0]*Double(currentRepeatedTests - 1) + totalAverage ) / Double(currentRepeatedTests)
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
       
        // prep the displayed chart
        var displayChartEntries = [ChartDataEntry]()
        
        // go thru all y values
        if ( yValues.count > 0 ) {
            
            for i in 0...(yValues.count - 1 ) {
                
                // set up the x and y axis values
                let value = ChartDataEntry( x: XValues[yValues.count - 1 - i], y: yValues[i] )
                print( "adding to x coord " , XValues[yValues.count - 1 - i], " and y coord " , yValues[i] )
                
                // add to the chartdataentry object
                displayChartEntries.append( value )//insert( value, at: 0 )
                
            }
            
            // make data set based on values and give it a name
            let lineY = LineChartDataSet( values: displayChartEntries, label: "Total Average Absolute Distance from Baseline" )
            
            // set up a data object
            let restTremorData = LineChartData()
            
            // add the data set to the data
            restTremorData.addDataSet(lineY )
            
            // give chart name and display data
            restTremorChart.chartDescription?.text = "Total Average Over the Past Thirty Days"
            restTremorChart.data = restTremorData
        }
    }
    
    // save chart to camera roll
    @IBAction func saveChart(_ sender: Any) {
        
        let theDate = Date()
        
        setCalendarDate(enteredDate: theDate.description)
        let theName = "Rest Tremor Chart - " + String( calendarDate[DAY] ) + " - " + String( calendarDate[ MONTH ] ) + " - " + String( calendarDate[YEAR] ) + ".png"
        
        restTremorChart.save(to: theName, format: ChartViewBase.ImageFormat.png, compressionQuality: 1.0)

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
