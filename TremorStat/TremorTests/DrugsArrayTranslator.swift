//
//  getDrugsArray.swift
//  TremorStat
//
//  Created by ikukushk on 12/2/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import Foundation

var medList = ["Medication A", "Medication B", "Medication C", "Medication D", "None"]
var supList = ["Vitamin A", "Vitamin C", "Vitamin D", "Vitamin E"]

func getDoubleDrugArray()->[[Double]]{
    
    var medArray = [String]()
    var supArray = [String]()
    
    if let UserMed = UserDefaults.standard.object(forKey: "UserMed") as? Array<String>
    {
        medArray = UserMed
    }
    
    if let UserSupp = UserDefaults.standard.object(forKey: "UserSupp") as? Array<String>
    {
        supArray = UserSupp
    }
    
    var d1 = [Double]()
    var d2 = [Double]()
    var doubleArray = [d1,d2]
    
    // get information abot medicine taken
    if (medArray.count > 0){
        print("MEDICATIONS:")
        for i in 0...medArray.count-1{
            if let j=medList.index(of: medArray[i]){
                (doubleArray[0]).append(Double(j))
                print(j)
            }
        }
    }
    
    // get information about supplements taken
    if (supArray.count > 0){
        print()
        print("SUPPLEMENTS:")
        for i in 0...supArray.count-1{
            if let j=supList.index(of: supArray[i]){
                (doubleArray[1]).append(Double(j))
                print(j)
            }
        }
    }
    
    return doubleArray
}


func getDrugString(doubleArray: [[Double]])->[String]{
    
    var returnString = ["",""]
    
    for i in 0...doubleArray[0].count-1{
        returnString[0]=returnString[0] + ", " + medList[Int(doubleArray[0][i])]
    }
    
    for i in 0...doubleArray[1].count-1{
        returnString[1]=returnString[1] + ", " + supList[Int(doubleArray[0][i])]
    }
    
    return returnString
}
