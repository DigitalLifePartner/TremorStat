//
//  StatisticsCalculator.swift
//  TremorStat
//
//  Created by Best Software on 11/10/17.
//  Copyright © 2017 Best Software. All rights reserved.
//


/*
 Purpose:   To aid with data analysis
 
 Version 1 of File:
 
 Complete:
 
 - added calcMean and calcStdDev
 
 To Do:
 
 - test functions
 - add other statistical stuff
 
 */
import UIKit
import simd

class StatisticsCalculator: NSObject {
    
    // MARK: Properties
    
    // the average
    var mean = 0.0
    
    // the middle most value of all the data in the set
    // var median = 0
    
    // the +- range where 50% of the data falls within the set
    var standardDeviation = 0.0
    
    
    // MARK: Implementation
    
    // overloaded function calcMean ( assuming do not want to take absolute val )
    func calcMean ( theData: Array<Double>, theSize: Int ) -> Double {
        
        let setToFalse = false
        return calcMean(theData: theData,theSize: theSize,absolute: setToFalse)
    }

    // find the average value within the set
    func calcMean( theData: Array<Double>, theSize: Int, absolute: Bool ) -> Double {
        
        // total value to average
        var totalCount = 0.0
        
        // size of the aray
        let size = theSize-1
        
        // should you wish to take the absolute value of all data in the set, this will
        // make sure that negative values become positive
        var dataToCount = 0.0
        
        // loop thru all values of the array
        for i in 0...size {
            
            // set the data to count towards the total to be the data in the array at index i
            dataToCount = theData[i]
            
            // if you wish to have the absolute value, and the value at index i is negative, make it positive
            if ( ( dataToCount < 0 ) && ( absolute == true ) ) {
                dataToCount = dataToCount*(-1)
            }
            
            // add value to total count
            totalCount = totalCount + dataToCount
        }
        
        // once done the total count - take the average
        self.mean = totalCount/Double(theSize)
        return self.mean
    }
    
    // calculate standard deviation -- call if you already have called calcMean
    func calcStdDev( theData: Array<Double>, theSize: Int ) -> Double {
        return calcStdDev( theData: theData, theSize: theSize, gotMean: true, absolute: false )
    }
    
    // another overloaded call -- call if there is discrepancy whether you called calcMean or not
    func calcStdDev( theData: Array<Double>, theSize: Int, gotMean: Bool ) -> Double {
        return calcStdDev( theData: theData, theSize: theSize, gotMean: gotMean, absolute: false )
    }
    
    // call this full version
    func calcStdDev( theData: Array<Double>, theSize: Int, gotMean: Bool, absolute: Bool ) -> Double {
        
        // calc the mean if it hasnt been calced yet
        if ( gotMean == false ) {
            self.mean = calcMean( theData: theData, theSize: theSize, absolute: true )
        }
        
        // to hold total count of the squares
        var totalCount = 0.0
        
        // for finding absolute values
        var dataToCount = 0.0
        
        // size of the array
        let size = theSize-1
        
        // loop thru all indices of the data set
        for i in 0...size {
            
            // set the data to count to the index in question
            dataToCount = theData[i]
            
            // if this data point is negative and we want to calc absolute value change it to positive
            if ( ( dataToCount < 0 ) && ( absolute == true ) ) {
                dataToCount = dataToCount*(-1)
            }
            
            // increment totalCount by new square difference from the mean
            totalCount = totalCount + ( dataToCount - self.mean )*( dataToCount - self.mean )
        }
        
        // square the totalcount divided by the size to obtain the standard deviation
        self.standardDeviation = (totalCount/Double(theSize)).squareRoot()
        return self.standardDeviation
    }
}
