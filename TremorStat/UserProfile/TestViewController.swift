//
//  TestUserProfileViewController.swift
//  TremorStat
//
//  Created by Dayton Pukanich on 11/16/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit
import Eureka

class TestViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form
        +++ Section("Default Questions")
            <<< DateRow() {
                $0.value = Date()
                $0.title = "Date of Birth"
            }

            <<< ActionSheetRow<String>() {
                $0.title = "Gender"
                $0.selectorTitle = "What is your gender?"
                $0.options = ["Male", "Female"]
                $0.value = "So hello"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Genetics"
                $0.selectorTitle = "Does your biological family have a history of Parkinson's disease?"
                $0.options = ["Yes", "No", "Unsure"]
                $0.value = "from the"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Cervical Trauma"
                $0.selectorTitle = "Have you experienced any neck damage throughout your lifetime?"
                $0.options = ["Yes", "No", "Unsure"]
                $0.value = "other"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Symptoms"
                $0.selectorTitle = "What is the severity of your symptoms related to Parkinson's disease?"
                $0.options = ["Not Diagnosed", "Mild", "Moderate", "Severe"]
                $0.value = "side"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
            }
        
        +++ Section("Additional Questions")
            <<< ActionSheetRow<String>() {
                $0.title = "Environmental Triggers"
                $0.selectorTitle = "Have you been exposed to pesicies or herbicides for a prolonged period of time?"
                $0.options = ["Yes", "No", "Unsure"]
                $0.value = "I must"
            }
            .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }
            <<< ActionSheetRow<String>() {
                $0.title = "Prescription Drugs"
                $0.selectorTitle = "Are you taking a prescription drug that effects the symptoms related to Parkinson's disease?"
                $0.options = ["No", "Levodopa"]
                $0.value = "have called"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }
            <<< ActionSheetRow<String>() {
                $0.title = "Supplements"
                $0.selectorTitle = "Are you taking the following vitamins and minerals?"
                $0.options = ["Diego Forlán", "Edinson Cavani", "Diego Lugano", "Luis Suarez"]
                $0.value = "a thousand"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }
            <<< ActionSheetRow<String>() {
                $0.title = "Hand"
                $0.selectorTitle = "What hand will you be using to perform the tests?"
                $0.options = ["Left", "Right"]
                $0.value = "times"
                }
                .onPresent { from, to in
                    to.popoverPresentationController?.permittedArrowDirections = .up
        }
    }
}
