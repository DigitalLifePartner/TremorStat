//  File Information:
//  DataStorage
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The class for the rest tremor test

import UIKit
import simd

/* PURPOSE: hold global data for app */
class DataStorage {

    // MARK: properties
    
    var firstTimeStart = true
    
    // rest tremor
    
    // past rest tremor test data
    var pastRestTremorDataArray: Array<Array<double3>>!
    
    // for average absolute amplitudes over multiple tests
    var totalRestTremorAvgAmpX: Double!
    var totalRestTremorAvgAmpY: Double!
    var totalRestTremorAvgAmpZ: Double!
    
    // for standard deviations of past tests
    var totalRestTremorAvgStdDevX: Double!
    var totalRestTremorAvgStdDevY: Double!
    var totalRestTremorAvgStdDevZ: Double!
    
    // action tremor test data
    
    
}
