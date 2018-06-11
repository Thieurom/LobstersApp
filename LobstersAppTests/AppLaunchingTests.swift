//
//  AppLaunchingTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class AppLaunchingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchingApp() {
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            XCTFail("Failed to initialize app")
            return
        }
        
        let initialViewController = navigationController.viewControllers.first
        
        XCTAssertNotNil(initialViewController)
        XCTAssertTrue(initialViewController is StoriesViewController)
    }
}
