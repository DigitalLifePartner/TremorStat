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

// amount of tests user must complete before conclusion will be calculated
let ACCEPTABLE_AMOUNT_OF_TESTS = 2

// based on our results ( all our averages added together with all our standad deviations ) + little extra leeway ( 0.125 --> 0.15 )
let AVG_PERSON_PLUS_STDDEV = 0.15

// double above value to catch large shakes
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
    
    
    // if the user wishes to know how they're doing recently, this button will cause recalculations based on only recent results
    @IBAction func recentTestsOnly(_ sender: Any) {
        displayInfo( displayRecentInfoOnly: true )
    }
    
    // MARK: overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // display info to user
    override func viewDidAppear(_ animated: Bool) {

        // display info to the user ( lifetime results )
        displayInfo( displayRecentInfoOnly: false )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Implementation
    
    // display info for user ( Summary of user profile ( bools ) -- Indication of completed amount of tests -- Conclusion )
    func displayInfo( displayRecentInfoOnly: Bool) {
        // SET UP SUMMARY PAGE
        
        // string that will be modular for the user profile summary
        var summaryString = " "
        
        // count used to see how many fields the user checks out for
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
        
        // print appropriate response as to why the previous data was displayed -- have gramatically correct case for singular factor
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
        
        // default the labels to blanks values
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
            
            // display amount of completed tests
            insufficientDataString = "You have completed " + String( restTremorResultArray.count ) + " tests."
            self.InsufficientDataLabel.text = insufficientDataString
            
            // used to calculate the users average shakiness
            var avgStat = 0.0
            
            // only run rest of calculations if tests have been completed
            if restTremorResultArray.count != 0 {
                
                // for singular test completed
                if restTremorResultArray.count == 1 {
                    avgStat = restTremorResultArray[0].testAverageX + restTremorResultArray[0].testAverageY + restTremorResultArray[0].testAverageZ
                }
                else {
                    
                    // the start index for the calculation
                    var startIndex = 0
                    
                    // if the user just wants to see recent data, change startIndex so it only accounts for new results
                    if ( displayRecentInfoOnly == true ) {
                        startIndex = restTremorResultArray.count - 1 - ACCEPTABLE_AMOUNT_OF_TESTS
                        
                        // catch negative cases
                        if( startIndex < 0 ) {
                            startIndex = 0
                        }
                    }
                    
                    // either go thru all tests or recent tests
                    for i in startIndex...(restTremorResultArray.count - 1) {
                        
                        // increment average based on averages of each test
                        avgStat += restTremorResultArray[i].testAverageX + restTremorResultArray[i].testAverageY + restTremorResultArray[i].testAverageZ
                        print ( " avgstat is ", avgStat )
                    }
                    
                }
                
                // take average
                avgStat = avgStat/Double( restTremorResultArray.count )
                
                // declare conclusionString to display results to the user
                var conclusionString: String!
                
                // if the users average was higher than our baseline plus our standard deviation --> they are higher than average but not drastically
                if ( avgStat > AVG_PERSON_PLUS_TWO_STDDEV ) {
                    
                    // string for if they do not have many factors
                    conclusionString = "You shake statistically higher than the average person. You do not have many contributing factors, but you should still consult a doctor for proper diagnosis. "
                    
                    // if the user does have a lot of additional factors in their profile, this higher than average value might not be a fluke...
                    if ( stringCount > 1 ) {
                        conclusionString = "You shake statistically higher than the average person. Additionally you have some factors that increase your risk. You should consult a doctor for proper diagnosis. "
                    }
                    
                }
                    
                // now if the user's average was higher than our average plus twice our standard deviation --> they are well above averages
                else if ( avgStat > AVG_PERSON_PLUS_STDDEV ) {
                    
                    // regardless of user profile we will recommend diagnosis at this point, but change message regardless
                    conclusionString = "You do shake more than the average person. You do not have many contributing factors though. The results are inconclusive."
                    if ( stringCount > 1 ) {
                        conclusionString = "You do shake more than the average person. As you do have some contributing factors there is a possibility that you have Parkinsons's. Consult a doctor for proper diagnosis. "
                    }
                    
                }
                else {
                    // user's average was within "average" range
                    conclusionString = "You are within the average ranges of shakiness that someone without Parkinson's has. So far you are fine. "
                }
                
                // update label text based on calculations above
                ConclusionLabel.text = conclusionString
                
            }
            else {
                
                // user has not done any tests yet
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
