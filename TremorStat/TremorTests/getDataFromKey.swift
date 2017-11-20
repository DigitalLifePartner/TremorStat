//  File Information:
//  getDataFromKey
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  Get the value of the string based on a key. Used for storing
//  data between instances

import Foundation

func getDataFromKey(key: String)->Array<[Double]>{
    var arrayCopy = [[Double]]()
    if let resultsArray = UserDefaults.standard.object(forKey: key) as? Array<[Double]>
    {
        arrayCopy = resultsArray
    }
    return arrayCopy
}
