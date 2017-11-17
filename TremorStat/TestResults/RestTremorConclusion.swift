//
//  RestTremorConclusion.swift
//  TremorStat
//
//  Created by Best Software on 11/16/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

/* Abstract
 
 Use collected data to make educated conclusion as to whether or not the person has parkinsons disease
 
 OR
 
 prevents user from seeing conclusion until sufficient data has been collected
 */

import UIKit

let ACCEPTABLE_AMOUNT_OF_TESTS = 2

let AVG_PERSON_PLUS_STDDEV = 0.15
let AVG_PERSON_PLUS_TWO_STDDEV = 0.3


class RestTremorConclusion: UIViewController {

    // MARK: properties
    let withinAgeRange = true
    let isMale = true
    let genetics = true
    let headTrauma = true
    
    @IBOutlet weak var SummaryLabel: UILabel!
    @IBOutlet weak var InsufficientDataLabel: UILabel!
    @IBOutlet weak var ConclusionLabel: UILabel!
    
    
    @IBAction func recentTestsOnly(_ sender: Any) {
        displayInfo( displayRecentInfoOnly: true )
    }
    
    // MARK: overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {

    
        displayInfo( displayRecentInfoOnly: false )
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Implementation
    
    func displayInfo( displayRecentInfoOnly: Bool) {
        // SET UP SUMMARY PAGE
        var summaryString = " "
        var stringCount = 0
        
        // construct string based on user profile
        if withinAgeRange {
            summaryString = summaryString + "You are above 45 years of age. "
            stringCount = stringCount + 1
        }
        if isMale {
            summaryString = summaryString + "You are male. "
            stringCount = stringCount + 1
        }
        if genetics {
            summaryString = summaryString + "Your family has a history of getting the disease. "
            stringCount = stringCount + 1
        }
        if headTrauma {
            summaryString = summaryString + "You have have head trauma in the past. "
            stringCount = stringCount + 1
        }
        
        // print appropriate response as to why the previous data was displayed
        if stringCount > 2 {
            summaryString = summaryString + " Each of these factors increase your chance of getting Parkinson's. "
        }
        else if stringCount == 1 {
            summaryString = summaryString + " This is a known factor that increases your chance of getting Parkinson's. "
        }
        
        // change summary label to display this data
        self.SummaryLabel.text = summaryString
        
        // for displaying to the user whether or not they have enough data to draw a conclusion from
        var insufficientDataString: String!
        insufficientDataString = " "
        self.InsufficientDataLabel.text = insufficientDataString
        self.ConclusionLabel.text = " "
        // if the amount of tests is less than the threshold - prevent user from seeing the data
        if ( restTremorResultArray.count < ACCEPTABLE_AMOUNT_OF_TESTS ) {
            
            // change label text
            insufficientDataString = "Not enough tests completed, requires more tests. Try again later. You have completed " + String( restTremorResultArray.count ) + " tests out of " + String( ACCEPTABLE_AMOUNT_OF_TESTS ) + "."
            self.InsufficientDataLabel.text = insufficientDataString
        }
        else {
            
            // conclusion
            insufficientDataString = "You have completed " + String( restTremorResultArray.count ) + " tests."
            self.InsufficientDataLabel.text = insufficientDataString
            //var statCalc = StatisticsCalculator()
            var avgStat = 0.0
            
            print( " array size is ", restTremorResultArray.count )
            if restTremorResultArray.count != 0 {
                if restTremorResultArray.count == 1 {
                    avgStat = restTremorResultArray[0].testAverageX + restTremorResultArray[0].testAverageY + restTremorResultArray[0].testAverageZ
                }
                else {
                    var startIndex = 0
                    if ( displayRecentInfoOnly == true ) {
                        startIndex = restTremorResultArray.count - 1 - ACCEPTABLE_AMOUNT_OF_TESTS
                        if( startIndex < 0 ) {
                            startIndex = 0
                        }
                    }
                    for i in startIndex...(restTremorResultArray.count - 1) {
                        
                        avgStat += restTremorResultArray[i].testAverageX + restTremorResultArray[i].testAverageY + restTremorResultArray[i].testAverageZ
                        print ( " avgstat is ", avgStat )
                        //stdDevStat += restTremorResultArray[i].testStdDevX + restTremorResultArray[i].testStdDevY + restTremorResultArray[i].testStdDevZ
                        //print ( " stddevstat is ", stdDevStat )
                    }
                    
                }
                
                avgStat = avgStat/Double( restTremorResultArray.count )
                print( "final avgStat is " , avgStat )
                //stdDevStat = stdDevStat/Double( restTremorResultArray.count )
                // print ( " final stddevstat is ", stdDevStat )
                
                var conclusionString: String!
                
                if ( avgStat > AVG_PERSON_PLUS_TWO_STDDEV ) {
                    
                    conclusionString = "You shake statistically higher than the average person. You do not have many contributing factors, but you should still consult a doctor for proper diagnosis. "
                    if ( stringCount > 1 ) {
                        conclusionString = "You shake statistically higher than the average person. Additionally you have some factors that increase your risk. You should consult a doctor for proper diagnosis. "
                    }
                    
                }
                else if ( avgStat > AVG_PERSON_PLUS_STDDEV ) {
                    
                    conclusionString = "You do shake more than the average person. You do not have many contributing factors though. The results are inconclusive."
                    if ( stringCount > 1 ) {
                        conclusionString = "You do shake more than the average person. As you do have some contributing factors there is a possibility that you have Parkinsons's. Consult a doctor for proper diagnosis. "
                    }
                    
                }
                else {
                    conclusionString = "You are within the average ranges of shakiness that someone without Parkinson's has. So far you are fine. "
                }
                
                ConclusionLabel.text = conclusionString
                
            }
            else {
                ConclusionLabel.text = "You do not have any test data yet."
            }
            
            
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
