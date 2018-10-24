//
//  TelstraAssessmentTests.swift
//  TelstraAssessmentTests
//
//  Created by Deepak Pillai on 23/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import XCTest
@testable import TelstraAssessment

class TelstraAssessmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTitleString(){
        
        let promise = expectation(description: "Title string value recieved")
        ServiceLayer.sharedInstance().getListData(completion: { (dataOject) in
            
            if (dataOject.title?.count)! > 0{
                
                promise.fulfill()
            }
            else{
                
                XCTFail("Unable to read title string from server")
            }
            
        }) { (errorObject) in
            
            XCTFail(errorObject.title!)
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    func testNetworkResponse(){
        
        let promise = expectation(description: "Data collected")
        ServiceLayer.sharedInstance().getListData(completion: { (dataOject) in
            
            promise.fulfill()
        }) { (errorObject) in
            
            XCTFail(errorObject.title!)
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}
