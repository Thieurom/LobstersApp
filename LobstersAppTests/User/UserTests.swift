//
//  UserTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasName() {
        let user = User(name: "Foo")
        
        XCTAssertEqual(user.name, "Foo")
    }
}
