//  File Information:
//  ActionTremorResultsClass
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The class for the action tremor test result


import UIKit
import simd

//MARK: Getter Methods
func getDate(array: Array<Double>)->Double{
    if array.count>AT_TIME{
    return array[AT_TIME]
    }
    return 0.0
}

func getFrequency(array: Array<Double>)->Double{
    if array.count>AT_FREQUENCY{
        return array[AT_FREQUENCY]
    }
    return 0.0
}

func getDeviance(array: Array<Double>)->Double{
    if array.count>AT_DEVIANCE{
        return array[AT_DEVIANCE]
    }
    return 0.0
}

class ActionTremorResultsClass {
    var frequency: Double!
    var deviance: Double!
    var testDate = Date()
}

