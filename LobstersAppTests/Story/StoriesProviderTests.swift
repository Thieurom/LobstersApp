//
//  StoriesProviderTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoriesProviderTests: XCTestCase {
    
    var sut: StoriesProvider!
    var story: Story!
    
    override func setUp() {
        super.setUp()
        
        sut = StoriesProvider()
        let user = User(name: "Foo")
        story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testStoriesCountInitiallyZero() {
        XCTAssertEqual(sut.storiesCount, 0)
    }
    
    func testSetStories() {
        sut.set(stories: [story])
        
        XCTAssertEqual(sut.storiesCount, 1)
    }
    
    func testAppendStories() {
        sut.append(stories: [story])
        
        XCTAssertEqual(sut.storiesCount, 1)
    }
    
    func testIndexOfStory() {
        XCTAssertNil(sut.index(of: story))
        
        sut.append(stories: [story])
        
        XCTAssertEqual(sut.index(of: story), 0)
    }
    
    func testStoryLastItem() {
        sut.append(stories: [story])
        
        XCTAssertEqual(sut.storiesCount, 1)
        XCTAssertTrue(sut.isLastItem(at: IndexPath(item: 0, section: 0)))
    }
}
