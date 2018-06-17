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
    var story: Story!
    
    override func setUp() {
        super.setUp()
        
        let user = User(name: "")
        let url = URL(string: "http://www.example.com")!
        story = Story(id: "1234", title: "", sourceURL: url, creationDate: Date(), submitter: user, commentCount: 0)
        
        storiesProvider = StoriesProvider()
        let fakeStoriesLoader = FakeStoriesLoader()
        
        sut = StoriesViewController(storiesProvider: storiesProvider, storiesLoader: fakeStoriesLoader)
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
        
        storiesProvider.set(stories: [story])
        
        let collectionView = sut.collectionView
        collectionView.reloadData()
        
        collectionView.delegate?.collectionView!(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        guard let storyViewController = mockNavigationController.lastPushedViewController as? StoryViewController else {
            XCTFail("An instance of StoryViewController should be pushed to stack")
            return
        }
        
        XCTAssertEqual(storyViewController.story.id, "1234")
        XCTAssertEqual(storyViewController.story.sourceURL, URL(string: "http://www.example.com"))
    }
    
    func testSetCellDelegate() {
        guard let storiesDataSource = sut.collectionView.dataSource as? StoriesDataSource else {
            XCTFail("DataSource should be an instance of StoriesDataSource")
            return
        }
        
        XCTAssertTrue(storiesDataSource.cellDelegate is StoriesViewController)
    }

    func testPressShareButtonOnCell() {
        storiesProvider.set(stories: [story])

        let collectionView = sut.collectionView
        collectionView.reloadData()
        collectionView.layoutIfNeeded()

        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
            XCTFail("Should get instance of StoryViewCell")
            return
        }

        cell.delegate?.storyViewCell(cell, didPressShareButton: cell.shareButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            XCTAssertNotNil(self.sut.presentedViewController)
            XCTAssertTrue(self.sut.presentedViewController is UIActivityViewController)
        }
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
    
    // MARK: - Fake Stories Loader
    
    class FakeStoriesLoader: StoriesLoader {
        
        init() {
            super.init(lobstersService: LobstersService())
        }
        
        override func storiesForNextPage(completion: @escaping (StoriesResult) -> Void) {
            completion(.success([]))
        }
    }
}
