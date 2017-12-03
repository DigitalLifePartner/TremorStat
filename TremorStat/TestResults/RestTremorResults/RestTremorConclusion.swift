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

/*import UIKit

// amount of tests user must complete before conclusion will be calculated
let ACCEPTABLE_AMOUNT_OF_TESTS = 2

// based on our results ( all our averages added together with all our standad deviations ) + little extra leeway ( 0.125 --> 0.15 )
let AVG_PERSON_PLUS_STDDEV = 0.15

// double above value to catch large shakes
let AVG_PERSON_PLUS_TWO_STDDEV = 0.3

// our average difference between tap time
let AVG_DEVIANCE = 0.1


class RestTremorConclusion: UIViewController {

    // MARK: properties
    //let withinAgeRange = true
    //let isMale = true
    //let genetics = true
    //let headTrauma = true
    
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
        
        // Get the data from the key
        //var restTremorResultArray = getDataFromKey(key: "restTremorResultArray")
        //var actionTremorResultArray = getDataFromKey(key: "actionTremorResultArray")
        
        var userAgeRange: String!
        var userGender: String!
        var userGenetics: String!
        var userHeadTrauma: String!
        var restTremorResultArray = [[[Double]]]()
        var actionTremorResultArray = [[[Double]]]()
        
        // get age from storage
        if let userAgeRangeKey = UserDefaults.standard.object(forKey: "UserDOB") as? String
        {
            userAgeRange = userAgeRangeKey
        }
        
        // get gender from storage
        if let userGenderKey = UserDefaults.standard.object(forKey: "UserGender") as? String
        {
            userGender = userGenderKey
        }
        
        // get family history from storage
        if let userGeneticsKey = UserDefaults.standard.object(forKey: "UserGenetics") as? String
        {
            userGenetics = userGeneticsKey
        }
        
        // get head trauma from storage
        if let userHeadTraumaKey = UserDefaults.standard.object(forKey: "UserTrauma") as? String
        {
            userHeadTrauma = userHeadTraumaKey
        }
        
        // get rest tremor array from storage
        if let restTremorResultArrayKey = UserDefaults.standard.object(forKey: "restTremorResultArray") as? [[[Double]]]
        {
            restTremorResultArray = restTremorResultArrayKey
        }
        
        // get action tremor array from storage
        if let actionTremorResultArrayKey = UserDefaults.standard.object(forKey: "actionTremorResultArray") as? [[[Double]]]
        {
            actionTremorResultArray = actionTremorResultArrayKey
        }
        // SET UP SUMMARY PAGE
        
        // string that will be modular for the user profile summary
        var summaryString = " "
        
        // count used to see how many fields the user checks out for
        var stringCount = 0
        
        // construct string based on user profile
        
        // get age range
        
        // user birthyear
        var currentYear = 0
        var birthYear = 0
        
        if ( userAgeRange != nil ) {
            var yearString = userAgeRange.description
            var yearIndex = yearString.index( yearString.startIndex, offsetBy: 4 )
            birthYear = Int( yearString.substring( to: yearIndex ) )!
            print ( "birthYear = " , birthYear)
            
            // current year
            yearString = Date().description
            yearIndex = yearString.index( yearString.startIndex, offsetBy: 4 )
            currentYear = Int( yearString.substring( to: yearIndex ) )!
        }
        
        
        if ( currentYear - birthYear >= 45 ) {
            summaryString = summaryString + "You are above 45 years of age. "
            stringCount = stringCount + 1
        }
        if ( userGender == "Male" ) {
            summaryString = summaryString + "You are male. "
            stringCount = stringCount + 1
        }
        if ( userGenetics == "Yes" ) {
            summaryString = summaryString + "Your family has a history of getting the disease. "
            stringCount = stringCount + 1
        }
        if ( userHeadTrauma == "Yes" ) {
            summaryString = summaryString + "You have have head trauma in the past. "
            stringCount = stringCount + 1
        }
        
        // print appropriate response as to why the previous data was displayed -- have gramatically correct case for singular factor
        if stringCount > 1 {
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
        /*if ( restTremorResultArray.count < ACCEPTABLE_AMOUNT_OF_TESTS ) {
            
            // change label text
            insufficientDataString = "Not enough tests completed, requires more tests. Try again later. You have completed " + String( restTremorResultArray.count ) + " rest tremor tests out of " + String( ACCEPTABLE_AMOUNT_OF_TESTS ) + " and " + String( actionTremorResultArray.count ) + " action tremor tests out of " + String( ACCEPTABLE_AMOUNT_OF_TESTS )
            self.InsufficientDataLabel.text = insufficientDataString
        }
        else {
            
            // conclusion
            // declare conclusionString to display results to the user
            var conclusionString: String!
            
            conclusionString = ""
            
            // display amount of completed tests
            insufficientDataString = "You have completed " + String ( actionTremorResultArray.count ) + " action tremor tests."
            insufficientDataString = insufficientDataString + " You have completed " + String( restTremorResultArray.count ) + " rest tremor tests."
            self.InsufficientDataLabel.text = insufficientDataString
            
            // used to calculate the users average shakiness
            var avgStat = 0.0
            
            // only run rest of calculations if tests have been completed
            if restTremorResultArray.count != 0 {
                
                // for singular test completed
                //calculate average offset
                
                // action first
                var actionTremorDeviance = 0.0
                var actionStartIndex = 0
                
                // catch case with 1 test
                if ( actionTremorResultArray.count == 1 ) {
                    actionTremorDeviance = actionTremorResultArray[0][AT_DEVIANCE][0]
                }
                else { // multiple tests
                    
                    // if user wants only recent data then only count recent tests
                    if ( displayRecentInfoOnly == true ) {
                        actionStartIndex = actionTremorResultArray.count - 1 - ACCEPTABLE_AMOUNT_OF_TESTS
                        
                        // catch negative cases
                        if( actionStartIndex < 0 ) {
                            actionStartIndex = 0
                        }
                    }
                    else {
                        // either go thru all tests or recent tests
                        for i in actionStartIndex...(actionTremorResultArray.count - 1) {
                            // increment average based on averages of each test
                            actionTremorDeviance = actionTremorResultArray[i][AT_DEVIANCE][0]
                            actionTremorDeviance = ( actionTremorDeviance*( Double( i - 1 ) ) ) / Double( i )
                            print ( " avgstat is ", avgStat )
                        }
                    }
                }
                
                // display whether or not the user has trouble maintaining a rythm
                if ( actionTremorDeviance > AVG_DEVIANCE ) {
                    conclusionString = conclusionString + "Based on the action tremor tests you have completed, it appears you have trouble maintaining a rythmic pattern of taps. "
                }
                else {
                    conclusionString = conclusionString + "Based on the action tremor tests you have completed, you appear to be able to maintain a rythmic pattern of taps. "
                }
                
                // now rest tremor
                if restTremorResultArray.count == 1 {
                    let xAverage = restTremorResultArray[0][RT_XAVERAGE][0]
                    let yAverage = restTremorResultArray[0][RT_YAVERAGE][0]
                    let zAverage = restTremorResultArray[0][RT_ZAVERAGE][0]
                    avgStat = xAverage + yAverage + zAverage
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
                        let xAverage = restTremorResultArray[i][RT_XAVERAGE][0]
                        let yAverage = restTremorResultArray[i][RT_YAVERAGE][0]
                        let zAverage = restTremorResultArray[i][RT_ZAVERAGE][0]
                        avgStat += xAverage + yAverage + zAverage
                        print ( " avgstat is ", avgStat )
                    }
                    
                }
                
                // take average
                avgStat = avgStat/Double( restTremorResultArray.count )
                
                // if the users average was higher than our baseline plus our standard deviation --> they are higher than average but not drastically
                if ( avgStat > AVG_PERSON_PLUS_TWO_STDDEV ) {
                    
                    // if the user does have a lot of additional factors in their profile, this higher than average value might not be a fluke...
                    if ( stringCount > 1 ) {
                        conclusionString = conclusionString + "It has been found from the rest tremor tests you have completed that there have been significant variations in the gryoscopic readings. Additionally you have some factors that increase your risk of Parkinson's. "
                    }
                    else {
                        // string for if they do not have many factors
                        conclusionString = conclusionString + "It has been found from the rest tremor tests you have completed that you shake statistically higher than the average person. You do not have many contributing factors, but you should still consult a doctor for proper diagnosis. "
                    }
                    
                }
                    
                // now if the user's average was higher than our average plus twice our standard deviation --> they are well above averages
                else if ( avgStat > AVG_PERSON_PLUS_STDDEV ) {
                    
                    // regardless of user profile we will recommend diagnosis at this point, but change message regardless
                    if ( stringCount > 1 ) {
                        conclusionString = conclusionString + "It has been found from the rest tremor tests you have completed that you do shake more than the average person. As you do have some contributing factors there is a possibility that you have Parkinsons's. Consult a doctor for proper diagnosis. "
                    }
                    else {
                        conclusionString = conclusionString + "It has been found from the rest tremor tests you have completed that you do shake more than the average person. You do not have many contributing factors though. The results are inconclusive."
                    }
                    
                }
                else {
                    // user's average was within "average" range
                    conclusionString = conclusionString + "It has been found from the rest tremor tests you have completed that you are within the average ranges of shakiness that someone without Parkinson's has. So far you are fine. "
                }
                
                // update label text based on calculations above
                ConclusionLabel.text = conclusionString
                
            }
            else {
                
                // user has not done any tests yet
                ConclusionLabel.text = "You do not have any test data yet."
            }
            
        }*/
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
