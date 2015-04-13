//
//  OnSetTests.swift
//  OnSetTests
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import XCTest




class OnSetTests: XCTestCase {
    
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
        XCTAssert(true, "Pass")
    }
    /*
    func testCorrectUser(){
        let SB = UIStoryboard(name: "Main", bundle: nil)
        myVC = SB.instantiateViewControllerWithIdentifier("profileView") as ViewController
        let_ = myVC.view
        let usernameWanted = "YRaFiKEFrZvffbqeXxjYtZsWR"
        var usernameCurrent = user["username"] as? String
        XCTAssertEqual(usernameWanted, usernameCurrent, "These two usernames should both be YRaFiKEFrZvffbqeXxjYtZsWR!!!!!")
    }
    func testLogIn(){
        
    }
    func testLogOut(){
        
    }
    func testProfileInformationRecovery(){
        
    }
    func testMovieInformationRecovery(){
        
    }
    */
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
