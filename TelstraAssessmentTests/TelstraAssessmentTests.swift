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
    
    //Testing collection view
    var vc = ViewController()
    func testControllerHasTableView() {
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.collectionView, "Controller should have a collectionView")
    }
    
    //Testing title value
    func testTitleString(){
        
        let promise = expectation(description: "Title string value recieved")
        ServiceLayer.sharedInstance().getListData(completion: { (dataOject) in
            
            XCTAssertTrue((dataOject.title?.count)! > 0, "Title cannot be empty")
            promise.fulfill()
            
        }) { (errorObject) in
            
            XCTFail(errorObject.title!)
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    //Testing internet reachiblity
    func testInternetReachiblity(){
        
        if !CommonUtilities.isConnectedToInternet(){
            
            XCTFail("Not connected to internet")
        }
    }
    //testing server list response 
    func testRowResponse(){
        
        let promise = expectation(description: "Data collected")
        ServiceLayer.sharedInstance().getListData(completion: { (dataOject) in
            
            XCTAssertTrue((dataOject.rows?.count)! > 0, "Data cannot be empty")
            promise.fulfill()
        }) { (errorObject) in
            
            XCTFail(errorObject.title!)
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}
