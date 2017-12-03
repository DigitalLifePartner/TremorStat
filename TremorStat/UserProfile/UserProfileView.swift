//  File Information:
//  UserProfileView
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The visulization of the user profile through the Eureka library

import UIKit
import Eureka

var userProfileResults = UserProfileClass()

class UserProfileView: Eureka.FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form
            +++ Section("Default Questions")
            <<< DateRow() {
                
                // define the minimum and maximum dates that are selectable for the date of birth
                let calendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian);
                let todayDate = NSDate()
                let components = calendar?.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day], from: todayDate as Date)
                let minimumYear = (components?.year)! - 1900
                let minimumMonth = (components?.month)! - 1
                let minimumDay = (components?.day)! - 1
                let comps = NSDateComponents();
                comps.year = -minimumYear
                comps.month = -minimumMonth
                comps.day = -minimumDay
                let minDate = calendar?.date(byAdding: comps as DateComponents, to: todayDate as Date, options: NSCalendar.Options.init(rawValue: 0))
                
                $0.value = todayDate as Date
                $0.maximumDate = todayDate as Date
                $0.minimumDate = minDate
                $0.title = "Date of Birth"
                
                if let UserDOB = UserDefaults.standard.object(forKey: "UserDOB") as? Date
                {
                    $0.value = UserDOB
                }
                }
                .onChange { row in
                    userProfileResults.dateOfBirth = row.value!
                    UserDefaults.standard.set(userProfileResults.dateOfBirth, forKey: "UserDOB")
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Gender"
                $0.selectorTitle = "What is your gender?"
                $0.options = ["Male", "Female"]
                if let UserGender = UserDefaults.standard.object(forKey: "UserGender") as? String
                {
                    $0.value = UserGender
                }
                }
                .onChange { row in
                    userProfileResults.gender = row.value!
                    UserDefaults.standard.set(userProfileResults.gender, forKey: "UserGender")
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Genetics"
                $0.selectorTitle = "Does your biological family have a history of Parkinson's disease?"
                $0.options = ["Yes", "No", "Unsure"]
                if let UserGenetics = UserDefaults.standard.object(forKey: "UserGenetics") as? String
                {
                    $0.value = UserGenetics;
                }
                }
                .onChange { row in
                    userProfileResults.genetics = row.value!
                    UserDefaults.standard.set(userProfileResults.genetics, forKey: "UserGenetics");
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Cervical Trauma"
                $0.selectorTitle = "Have you experienced any neck damage throughout your lifetime?"
                $0.options = ["Yes", "No", "Unsure"]
                if let UserTrauma = UserDefaults.standard.object(forKey: "UserTrauma") as? String
                {
                    $0.value = UserTrauma;
                }
                }
                .onChange { row in
                    userProfileResults.trauma = row.value!
                    UserDefaults.standard.set(userProfileResults.trauma, forKey: "UserTrauma");
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Symptoms"
                $0.selectorTitle = "What is the severity of your symptoms related to Parkinson's disease?"
                $0.options = ["Not Diagnosed", "Mild", "Moderate", "Severe"]
                if let UserStage = UserDefaults.standard.object(forKey: "UserStage") as? String
                {
                    $0.value = UserStage;
                }
                }
                .onChange { row in
                    userProfileResults.stage = row.value!
                    UserDefaults.standard.set(userProfileResults.stage, forKey: "UserStage")
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            
            <<< ActionSheetRow<String>() {
                $0.title = "Hand"
                $0.selectorTitle = "What hand will you be using to perform the tests?"
                $0.options = ["Left", "Right"]
                if let UserHand = UserDefaults.standard.object(forKey: "UserHand") as? String
                {
                    $0.value = UserHand
                }
                }
                .onChange { row in
                    userProfileResults.hand = row.value!
                    UserDefaults.standard.set(userProfileResults.hand, forKey: "UserHand")
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            
            +++ Section("Additional Questions")
            <<< MultipleSelectorRow<String>() {
                $0.title = "Environmental Triggers"
                $0.selectorTitle = "Environmental Triggers"
                $0.options = ["Herbicides", "Pesticides"]
                if let UserEnv = UserDefaults.standard.object(forKey: "UserEnv") as? Array<Any>
                {
                    let temp_UserEnv = Set(UserEnv as! [String])
                    $0.value = temp_UserEnv;
                }
                }
                .onChange { row in
                    userProfileResults.triggers = row.value!
                    let dataToStore = Array(userProfileResults.triggers)
                    UserDefaults.standard.set(dataToStore, forKey: "UserEnv")
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileView.multipleSelectorDone(_:)))
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "Prescription Drugs"
                $0.options = ["Vitamin A", "Vitamin C", "Vitamin D", "Vitamin E"]
                if let UserDrugs = UserDefaults.standard.object(forKey: "UserDrugs")as? Array<Any>
                {
                    let temp_UserDrugs = Set(UserDrugs as! [String])
                    $0.value = temp_UserDrugs
                }
                }
                .onChange { row in
                    userProfileResults.drugs = row.value!
                    let dataToStore = Array(userProfileResults.drugs);
                    UserDefaults.standard.set(dataToStore, forKey: "UserDrugs")
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileView.multipleSelectorDone(_:)))
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "Supplements"
                $0.selectorTitle = "Supplements"
                $0.options = ["Vitamin A", "Vitamin C", "Vitamin D", "Vitamin E"]
                if let UserSupp = UserDefaults.standard.object(forKey: "UserSupp") as? Array<Any>
                {
                    let temp_UserSupp = Set(UserSupp as! [String])
                    $0.value = temp_UserSupp
                }
                }
                .onChange { row in
                    userProfileResults.supplements = row.value!
                    let dataToStore = Array(userProfileResults.supplements)
                    UserDefaults.standard.set(dataToStore, forKey: "UserSupp")
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileView.multipleSelectorDone(_:)))
            }
            
            <<< MultipleSelectorRow<String>() {
                $0.title = "Parkinson's Medication"
                $0.selectorTitle = "Medication"
                $0.options = ["Medication A", "Medication B", "Medication C", "Medication D", "None"]
                if let UserMed = UserDefaults.standard.object(forKey: "UserMed") as? Array<Any>
                {
                    let temp_UserMed = Set(UserMed as! [String])
                    $0.value = temp_UserMed
                }
                }
                .onChange { row in
                    userProfileResults.supplements = row.value!
                    let dataToStore = Array(userProfileResults.supplements)
                    UserDefaults.standard.set(dataToStore, forKey: "UserMed")
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileView.multipleSelectorDone(_:)))
        }
        
        
        
        
        
        
    }
    
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

