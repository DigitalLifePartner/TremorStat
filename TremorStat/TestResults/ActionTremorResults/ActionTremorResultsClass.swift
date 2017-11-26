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
    if array.count>0{
    return array[0]
    }
    return 0.0
}

func getFrequency(array: Array<Double>)->Double{
    if array.count>1{
        return array[1]
    }
    return 0.0
}

func getDeviance(array: Array<Double>)->Double{
    if array.count>2{
        return array[2]
    }
    return 0.0
}

class ActionTremorResultsClass {
    var frequency: Double!
    var deviance: Double!
    var testDate = Date()
}

