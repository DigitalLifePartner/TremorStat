//
//  TremorStatConclusion.swift
//  TremorStat
//
//  Created by Best Software on 11/16/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

/* Abstract
 
Display to user their risk factors based on their profile
 
 */

import UIKit

// amount of tests user must complete before conclusion will be calculated
let ACCEPTABLE_AMOUNT_OF_TESTS = 2

// based on our results ( all our averages added together with all our standad deviations ) + little extra leeway ( 0.125 --> 0.15 )
let AVG_PERSON_PLUS_STDDEV = 0.15

// double above value to catch large shakes
let AVG_PERSON_PLUS_TWO_STDDEV = 0.3

// our average difference between tap time
let AVG_DEVIANCE = 0.1


class TremorStatConclusion: UIViewController {
    
    // MARK: properties

    
    @IBOutlet weak var AgeFactor: UILabel!
    
    @IBOutlet weak var GenderFactor: UILabel!
    
    @IBOutlet weak var HistoryFactor: UILabel!
    @IBOutlet weak var TraumaFactor: UILabel!
    @IBOutlet weak var NoFactors: UILabel!
    // if the user wishes to know how they're doing recently, this button will cause recalculations based on only recent results
    
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
        
        var userAgeRange = Date()
        var userGender: String!
        var userGenetics: String!
        var userHeadTrauma: String!
        var restTremorResultArray = [[[Double]]]()
        var actionTremorResultArray = [[[Double]]]()
        
        // get age from storage
        if let userAgeRangeKey = UserDefaults.standard.object(forKey: "UserDOB") as? Date
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
        
        // SET UP SUMMARY PAGE
        
        // construct string based on user profile
        
        // get age range
        
        // user birthyear
        var currentYear = 0
        var birthYear = 0
        
        if ( userAgeRange != nil ) {
            var yearString = userAgeRange.description
            var yearIndex = yearString.index( yearString.startIndex, offsetBy: 4 )
            birthYear = Int( yearString.substring( to: yearIndex ) )!
            
            // current year
            yearString = Date().description
            yearIndex = yearString.index( yearString.startIndex, offsetBy: 4 )
            currentYear = Int( yearString.substring( to: yearIndex ) )!
        }
        
        // default factor texts
        AgeFactor.text = ""
        GenderFactor.text = ""
        HistoryFactor.text = ""
        TraumaFactor.text = ""
        NoFactors.text = ""
        
        var noFactors = true
        
        // if user is in age range, let them know
        if ( currentYear - birthYear >= 45 ) {
            AgeFactor.text! = "You are around " + String( currentYear - birthYear ) + " years of age. Most cases of Parkinson's are diagnosed when the patient is over 50 years of age. Aging also affects neurological processes, increasing your risk."
            noFactors = false
        }
        
        // if user is male, then let them know they are more at risk
        if ( userGender == "Male" ) {
            GenderFactor.text! = "You are male. Men have been found to be more susceptible to Parkinson's than women."
            noFactors = false
        }
        
        // let the user know that genetics is a factor
        if ( userGenetics == "Yes" ) {
            HistoryFactor.text! = "Your family has a history of getting the disease. Genetics has been found to be a risk factor."
            noFactors = false
        }
        
        // head trauma obviously affects their risk
        if ( userHeadTrauma == "Yes" ) {
            TraumaFactor.text! = "You have had head trauma in the past. This may have affected your neurological processes, increasing your risk."
            noFactors = false
        }
        
        // display this if they "don't have factors"
        if ( noFactors ) {
            NoFactors.text! = "Based on your user profile, you do not have any risk factors."
        }
        
    }
    
}

