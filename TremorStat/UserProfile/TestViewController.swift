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
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
}
