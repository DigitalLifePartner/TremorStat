//
//  RestTremorClass.swift
//  TremorStat
//
//  Created by ikukushk on 11/14/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import UIKit
import simd

class RestTremorResultsClass {
    var gyroArrayX = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayY = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayZ = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var testDate = Date()
    
    var testAverageX: Double!
    var testAverageY: Double!
    var testAverageZ: Double!
    
    var testStdDevX: Double!
    var testStdDevY: Double!
    var testStdDevZ: Double!
}
