//
//  StoriesViewControllerTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoriesViewControllerTests: XCTestCase {
    
    var sut: StoriesViewController!
    var storiesProvider: StoriesProvider!
    
    override func setUp() {
        super.setUp()
        
        storiesProvider = StoriesProvider()
        let storiesLoader = StoriesLoader(lobstersService: LobstersService())
        
        sut = StoriesViewController(storiesProvider: storiesProvider, storiesLoader: storiesLoader)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testHasCollectionView() {
        XCTAssertTrue(sut.collectionView.isDescendant(of: sut.view))
    }
    
    func testSetCollectionViewDataSource() {
        XCTAssertTrue(sut.collectionView.dataSource is StoriesDataSource)
    }
    
    func testSetCollectionViewDelegate() {
        XCTAssertTrue(sut.collectionView.delegate is StoriesDataSource)
    }
    
    func testCollectionViewDataSourceEqualDelegate() {
        XCTAssertEqual(sut.collectionView.dataSource as? StoriesDataSource, sut.collectionView.delegate as? StoriesDataSource)
    }
    
    func testSetStoryDelegate() {
        guard let storiesDataSource = sut.collectionView.dataSource as? StoriesDataSource else {
            XCTFail("DataSource should be an instance of StoriesDataSource")
            return
        }
        
        XCTAssertTrue(storiesDataSource.storyDelegate is StoriesViewController)
    }
    
    func testShowStoryViewControllerWhenSelectingCell() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        let user = User(name: "")
        let url = URL(string: "http://www.example.com")!
        let story = Story(id: "1234", title: "", sourceURL: url, creationDate: Date(), submitter: user, commentCount: 0)
        storiesProvider.set(stories: [story])
        
        let collectionView = sut.collectionView
        collectionView.reloadData()
        
        collectionView.delegate?.collectionView!(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        guard let storyViewController = mockNavigationController.lastPushedViewController as? StoryViewController else {
            XCTFail("An instance of StoryViewController should be pushed to stack")
            return
        }
        
        XCTAssertEqual(storyViewController.story.id, "1234")
        XCTAssertEqual(storyViewController.story.sourceURL, url)
    }
}

// MARK: -

extension StoriesViewControllerTests {
    
    // MARK: - Mock UINavigationController
    
    class MockNavigationController: UINavigationController {
        
        var lastPushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            lastPushedViewController = viewController
            
            super.pushViewController(viewController, animated: animated)
        }
    }
}
