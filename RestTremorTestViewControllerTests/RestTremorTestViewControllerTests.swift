//
//  TremorStatTests.swift
//  TremorStatTests
//
//  Created by Dayton Pukanich on 11/6/17.
//  Copyright © 2017 Best Software. All rights reserved.
//

import XCTest

var dataStoringTestResult = true

class RestTremorTestViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // MARK: Test to check proper data storage
    func DataStoringTest(var1: Double,var2: Double){
        dataStoringTestResult=dataStoringTestResult && (var1==var2)
    }
    
}
