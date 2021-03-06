//
//  StoryViewControllerTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
import WebKit
@testable import LobstersApp

class StoryViewControllerTests: XCTestCase {
    
    var sut: StoryViewController!
    var story: Story!
    
    override func setUp() {
        super.setUp()
        
        let user = User(name: "Foo")
        let url = URL(string: "http://www.example.com")!
        story = Story(id: "1234", title: "Bar", sourceURL: url, creationDate: Date(), submitter: user, commentCount: 0)
        sut = StoryViewController(story: story)
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHasWebView() {
        XCTAssertTrue(sut.webView.isDescendant(of: sut.view))
    }
    
    func testNavigationDelegate() {
        XCTAssertTrue(sut.webView.navigationDelegate is StoryViewController)
    }
    
    func testLoadStoryAfterViewDidLoad() {
        let mockWebView = MockWebView()
        sut = StoryViewController(story: story)
        sut.webView = mockWebView
        
        sut.loadViewIfNeeded()
        
        guard let request = mockWebView.caughtRequest else {
            XCTFail("Should catch request")
            return
        }
        
        XCTAssertEqual(request.url, story.sourceURL)
    }
    
    func testPressShareButton() {
        sut.shareButton.sendActions(for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            XCTAssertNotNil(self.sut.presentedViewController)
            XCTAssertTrue(self.sut.presentedViewController is UIActivityViewController)
        }
    }
    
    func testPressCommentButton() {
        let mockNavigationController = StoriesViewControllerTests.MockNavigationController(rootViewController: sut)
        
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        sut.commentButton.sendActions(for: .touchUpInside)
        
        guard let commentsViewController = mockNavigationController.lastPushedViewController as? CommentsViewController else {
            XCTFail("An instance of CommentsViewController should be pushed to stack")
            return
        }
        
        XCTAssertEqual(commentsViewController.story.id, "1234")
    }
}

// MARK: -

extension StoryViewControllerTests {
    
    // MARK: - Mock WebView
    
    class MockWebView: WKWebView {
        
        var caughtRequest: URLRequest?
        
        override func load(_ request: URLRequest) -> WKNavigation? {
            caughtRequest = request
            return nil
        }
    }
}
