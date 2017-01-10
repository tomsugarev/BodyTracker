//
//  BodyTrackTests.swift
//  BodyTrackTests
//
//  Created by Tom Sugarex on 13/06/2015.
//  Copyright (c) 2015 Tom Sugarex. All rights reserved.
//

import UIKit
import XCTest
@testable import BodyTrack

class BodyTrackTests: XCTestCase {

    var progressPoint = ProgressPoint()
    
    override func setUp() {
        super.setUp()
        
        progressPoint.date = Date()
        progressPoint.bodyFat = 10
        progressPoint.measurement = 12
        progressPoint.weight = 79
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
