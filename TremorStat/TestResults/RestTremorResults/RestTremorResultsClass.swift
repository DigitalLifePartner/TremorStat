//  File Information:
//  RestTremorResultsClass
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The class for the rest tremor test result

import UIKit
import simd

//MARK: Getter Methods
func getAverageX(array: Array<Double>)->Double{
    if array.count>1{
        return array[1]
    }
    return 0.0
}

func getAverageY(array: Array<Double>)->Double{
    if array.count>2{
        return array[2]
    }
    return 0.0
}

func getAverageZ(array: Array<Double>)->Double{
    if array.count>3{
        return array[3]
    }
    return 0.0
}

func getStdDevX(array: Array<Double>)->Double{
    if array.count>4{
        return array[4]
    }
    return 0.0
}

func getStdDevY(array: Array<Double>)->Double{
    if array.count>5{
        return array[5]
    }
    return 0.0
}

func getStdDevZ(array: Array<Double>)->Double{
    if array.count>6{
        return array[6]
    }
    return 0.0
}

class RestTremorResultsClass {
    var gyroArrayX: Array<Double> = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayY: Array<Double> = Array(repeating: 0.0, count: READINGS_PER_TEST)
    var gyroArrayZ: Array<Double> = Array(repeating: 0.0, count: READINGS_PER_TEST)
    
    var testDate = Date()
    
    var testAverageX: Double!
    var testAverageY: Double!
    var testAverageZ: Double!
    
    var testStdDevX: Double!
    var testStdDevY: Double!
    var testStdDevZ: Double!
}
