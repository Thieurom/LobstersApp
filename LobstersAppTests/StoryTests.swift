//
//  StoryTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoryTests: XCTestCase {
    
    var user: User!
    var date: Date!
    
    override func setUp() {
        super.setUp()
        
        user = User(name: "Foo")
        date = Date()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStoryHasId() {
        let story = Story(id: "abc123", title: "", sourceURL: nil, creationDate: date, submitter: user, commentCount: 0)
        
        XCTAssertEqual(story.id, "abc123")
    }
    
    func testHasTitle() {
        let story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: date, submitter: user, commentCount: 0)
        
        XCTAssertEqual(story.title, "Bar")
    }
    
    func testHasSourceURL() {
        let url = URL(string: "http://www.example.com")!
        let story = Story(id: "", title: "", sourceURL: url, creationDate: date, submitter: user, commentCount: 0)
        
        XCTAssertEqual(story.sourceURL, url)
    }
    
    func testHasCreationDate() {
        let story = Story(id: "", title: "", sourceURL: nil, creationDate: date, submitter: user, commentCount: 0)
        
        XCTAssertEqual(story.creationDate, date)
    }
    
    func testHasSubmitter() {
        let story = Story(id: "", title: "", sourceURL: nil, creationDate: date, submitter: user, commentCount: 0)
        
        XCTAssertEqual(story.submitter.name, "Foo")
    }
    
    func testHasCommentCount() {
        let story = Story(id: "", title: "", sourceURL: nil, creationDate: date, submitter: user, commentCount: 999)
        
        XCTAssertEqual(story.commentCount, 999)
    }
}
