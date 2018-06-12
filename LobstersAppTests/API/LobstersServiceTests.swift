//
//  LobstersServiceTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class LobstersServiceTests: XCTestCase {
    
    var sut: LobstersService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPopularStoriesUseCorrectURL() {
        let mockURLSession = MockURLSession()
        sut = LobstersService(session: mockURLSession)
        
        sut.popularStories(page: 1234)
        
        guard let request = mockURLSession.caughtRequest else {
            XCTFail("Should catch request")
            return
        }
        
        guard let url = request.url else {
            XCTFail("Request should catch url")
            return
        }
        
        XCTAssertEqual(url.host, "lobste.rs")
        XCTAssertEqual(url.path, "")
        XCTAssertEqual(url.query, "page=1234")
    }
    
    func testPopularStoriesAcceptJSON() {
        let mockURLSession = MockURLSession()
        sut = LobstersService(session: mockURLSession)
        
        sut.popularStories(page: 1234)
        
        guard let request = mockURLSession.caughtRequest else {
            XCTFail("Should catch request")
            return
        }
        
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
    }
}

// MARK: -

extension LobstersServiceTests {
    
    // MARK: - Mock URLSession
    
    class MockURLSession: URLSession {
        var caughtRequest: URLRequest?
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            caughtRequest = request
            return URLSessionDataTask()
        }
    }
}
