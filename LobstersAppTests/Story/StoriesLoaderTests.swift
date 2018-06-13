//
//  StoriesLoaderTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoriesLoaderTests: XCTestCase {
    
    var sut: StoriesLoader!
    var fakeService: FakeLobstersService!
    
    override func setUp() {
        super.setUp()
        
        fakeService = FakeLobstersService()
        sut = StoriesLoader(lobstersService: fakeService)
    }
    
    override func tearDown() {
        sut.resetToFirstPage()
        
        super.tearDown()
    }
    
    func testLoadStoriesReturnStoriesResult() {
        let resultExpectation = expectation(description: "Result")
        var loadedResult: StoriesResult?
        
        sut.storiesForNextPage { (result) in
            loadedResult = result
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertNotNil(loadedResult)
        }
    }
    
    func testLoadStoriesStartLoadingWithPageOfOne() {
        XCTAssertEqual(sut.nextPage, 1)

        let pageExpectation = expectation(description: "Next Page")
        var page: Int?
        
        sut.storiesForNextPage { (_) in
            page = self.fakeService.currentPage
            pageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(page, 1)
        }
    }
    
    func testLoadStoriesIncreasePageCounter() {
        XCTAssertEqual(sut.nextPage, 1)
        
        let pageExpectation = expectation(description: "Next Page")
        
        sut.storiesForNextPage { (_) in
            pageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(self.sut.nextPage, 2)
        }
    }
    
    func testResetToFirsPage() {
        XCTAssertEqual(sut.nextPage, 1)
        
        let pageExpectation = expectation(description: "Next Page")
        
        sut.storiesForNextPage { (_) in
            pageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(self.sut.nextPage, 2)
        }
        
        sut.resetToFirstPage()
        XCTAssertEqual(sut.nextPage, 1)
    }
}

// MARK: -

extension StoriesLoaderTests {
    
    // MARK: - Fake Lobsters Service
    
    class FakeLobstersService: LobstersService {
        
        var currentPage: Int?
        
        override func popularStories(page: Int, completion: @escaping (StoriesResult) -> Void) {
            currentPage = page
            
            let user = User(name: "Foo")
            let story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
            
            completion(.success([story]))
        }
    }
}
