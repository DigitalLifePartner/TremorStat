//
//  getDataFromKey.swift
//  TremorStat
//
//  Created by Milos Savic on 11/18/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import Foundation

func getDataFromKey(key: String)->Array<[Double]>{
    var arrayCopy = [[Double]]()
    if let resultsArray = UserDefaults.standard.object(forKey: key) as? Array<[Double]>
    {
        arrayCopy = resultsArray
    }
    return arrayCopy
}
