//  File Information:
//  UserProfileClass
//
//  Created by Best Software
//  Copyright © 2017 Best Software. All rights reserved.
//
//  Abstract:
//  The class for user profile

import Foundation

class UserProfileClass {
    
    var dateOfBirth = Date()
    var gender: String!
    var genetics: String!
    var trauma: String!
    var stage: String!
    
    var triggers: Set<String> = Set()
    var drugs: Set<String> = Set()
    var supplements: Set<String> = Set()
    var hand: String!
}
