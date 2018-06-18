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
    var storyViewModel: StoryViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = StoriesProvider()
        let user = User(name: "Foo")
        let story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
        storyViewModel = StoryViewModel(story: story)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testStoriesCountInitiallyZero() {
        XCTAssertEqual(sut.itemsCount, 0)
    }
    
    func testSetStories() {
        sut.set(items: [storyViewModel])
        
        XCTAssertEqual(sut.itemsCount, 1)
    }
    
    func testAppendStories() {
        sut.append(items: [storyViewModel])
        
        XCTAssertEqual(sut.itemsCount, 1)
    }
    
    func testIndexOfStory() {
        XCTAssertNil(sut.index(of: storyViewModel))
        
        sut.append(items: [storyViewModel])
        
        XCTAssertEqual(sut.index(of: storyViewModel), 0)
    }
    
    func testStoryLastItem() {
        sut.append(items: [storyViewModel])
        
        XCTAssertEqual(sut.itemsCount, 1)
        XCTAssertTrue(sut.isLastItem(at: IndexPath(item: 0, section: 0)))
    }
}
