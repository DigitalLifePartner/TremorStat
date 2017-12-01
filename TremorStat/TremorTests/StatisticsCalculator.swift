//  File Information:
//  StatisticsCalculator
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Used to perform any statistic calculations for data analysis and visulization

import UIKit
import simd

class StatisticsCalculator {
    
    // MARK: Properties
    
    // the average
    var mean = 0.0
    
    // the middle most value of all the data in the set
    // var median = 0
    
    // the +- range where 50% of the data falls within the set
    var standardDeviation = 0.0
    
    
    // MARK: Implementation
    
    // overloaded function calcMean ( assuming do not want to take absolute val )
    /*func calcMean ( theData: Array<Double>, theSize: Int ) -> Double {
        
        let setToFalse = false
        return calcMean(theData: theData,theSize: theSize,absolute: setToFalse)
    }*/
    func sigFigs( theData: Double, amountOfFigs: Int ) -> Double {
        
        var powerOfTen = 1.0
        for _ in 1...amountOfFigs {
            powerOfTen = powerOfTen*10.0
        }
        var multData = powerOfTen*theData
        var intData = Int(multData)
        multData = Double(intData)
        multData = multData/100000.0
        return multData
    }

    // find the average value within the set
    func calcMean( theData: Array<Double>, theSize: Int, absolute: Bool ) -> Double {
        
        print( "Entered calcMean" )
        // total value to average
        var totalCount = 0.0
        
        // size of the aray
        let size = theSize-1
        
        // should you wish to take the absolute value of all data in the set, this will
        // make sure that negative values become positive
        var dataToCount = 0.0
        
        // loop thru all values of the array
        for i in 0...size {
            print( "Loop iter " , i )
            // set the data to count towards the total to be the data in the array at index i
            dataToCount = theData[i]
            
            // if you wish to have the absolute value, and the value at index i is negative, make it positive
            if ( ( dataToCount < 0 ) && ( absolute == true ) ) {
                print( "data was negative" )
                dataToCount = dataToCount*(-1)
                print( "made it postive" )
            }
            
            // add value to total count
            totalCount = totalCount + dataToCount
        }
        print( "exited loop with ", totalCount )
        // once done the total count - take the average
        
        print( "calcing mean" )
        self.mean = totalCount/Double(theSize)
        print( "got the mean" )
        return self.mean
    }
    
    // calculate standard deviation -- call if you already have called calcMean
    /*func calcStdDev( theData: Array<Double>, theSize: Int ) -> Double {
        return calcStdDev( theData: theData, theSize: theSize, gotMean: true, absolute: false )
    }
    
    // another overloaded call -- call if there is discrepancy whether you called calcMean or not
    func calcStdDev( theData: Array<Double>, theSize: Int, gotMean: Bool ) -> Double {
        return calcStdDev( theData: theData, theSize: theSize, gotMean: gotMean, absolute: false )
    }*/
    
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
    
    // check if the two inputs are within the same range
    func isWithinRange( first: Double, second: Double, range: Double ) -> Bool {
        
        var retVal = false
        
        // if they are within a plus minus range of each other return true else false
        if ( ( first >= second - range ) || ( first <= second - range ) ) {
            retVal = true
        }
        return retVal
    }
    
    // take in an array and return an array with values close to the search key's value
    func searchAndMakeWithinRange( theArray: [Double], searchKey: Double, range: Double ) -> [Double] {
        var retArray = [Double]()
        
        // go thru array
        for i in 0...( theArray.count - 1 ) {
            
            // if the value is similar to the key, add it to the returned array
            if ( isWithinRange( first: theArray[i], second: searchKey, range: range ) ) {
                retArray.append( theArray[i] )
            }
        }
        return retArray
    }
    
    // similar to isWithinRange, but now is not a plus minus range but a variable interval
    func isWithinInterval( first: Double, leftMostVal: Double, rightMostVal: Double ) -> Bool {
        
        var retVal = false
        
        // if the value is within the given interval return true else false
        if ( ( first >= leftMostVal ) && ( first <= rightMostVal ) ) {
            retVal = true
        }
        return retVal
    }
    
    // similar to the one with the range, but not with an interval instead
    func searchAndMakeWithinInterval( theArray: [Double], leftMostVal: Double, rightMostVal: Double ) -> [Double] {
        var retArray = [Double]()
        
        // go thru array
        for i in 0...( theArray.count - 1 ) {
            
            // if the value is within the interval add it to the returned array
            if ( isWithinInterval( first: theArray[i], leftMostVal: leftMostVal, rightMostVal: rightMostVal ) ) {
                retArray.append( theArray[i] )
            }
        }
        return retArray
    }
}
