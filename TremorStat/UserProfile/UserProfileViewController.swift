//
//  SecondUserProfileViewController.swift
//  TremorStat
//
//  Created by Dayton Pukanich on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit
import Eureka

class UserProfileViewController: FormViewController {
    
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
            <<< MultipleSelectorRow<String>() {
                $0.title = "Environmental Triggers"
                $0.options = ["Herbicides", "Pesicies"]
                $0.value = ["I must"]
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileViewController.multipleSelectorDone(_:)))
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "Prescription Drugs"
                $0.options = ["Vitamin A", "Vitamin C", "Vitamin D", "Vitamin E"]
                $0.value = ["have called"]
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileViewController.multipleSelectorDone(_:)))
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "Supplements"
                $0.options = ["Vitamin A", "Vitamin C", "Vitamin D", "Vitamin E"]
                $0.value = ["a thousand"]
                }
                .onPresent { from, to in
                    to.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(UserProfileViewController.multipleSelectorDone(_:)))
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
    
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

