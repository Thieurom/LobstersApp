//
//  StoriesDataSourceTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoriesDataSourceTests: XCTestCase {
    
    var sut: StoriesDataSource!
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        sut = StoriesDataSource()
        let storiesProvider = StoriesProvider()
        sut.provider = storiesProvider
        
        let storiesLoader = StoriesLoader(lobstersService: LobstersService())
        let controller = StoriesViewController(storiesProvider: storiesProvider, storiesLoader: storiesLoader)
        controller.loadViewIfNeeded()
        
        collectionView = controller.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = sut
        
        let user = User(name: "Foo")
        let story = Story(id: "1234", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
        let storyViewModel = StoryViewModel(story: story)
        
        storiesProvider.set(items: [storyViewModel])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
    
    func testNumbewOfItems() {
        collectionView.reloadData()
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func testCellForItemReturnStoryViewCell() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(cell is StoryViewCell)
    }
    
    func testCellForItemDequeueFromCollectionView() {
        let mockCollectionView = MockCollectionView.mockCollectionView()
        mockCollectionView.dataSource = sut
        mockCollectionView.delegate = sut

        mockCollectionView.reloadData()
        mockCollectionView.layoutIfNeeded()
        
        _ = mockCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockCollectionView.cellGotDequeued)
    }
    
    func testCellForItemSetViewModelToCell() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
            XCTFail("Fail to dequeue correct cell")
            return
        }
        
        XCTAssertNotNil(cell.viewModel)
        XCTAssertEqual(cell.viewModel?.story.title, "Bar")
    }
    
    func testCellWillDisplayCallDelegateMethod() {
        let mockStoryDelegate = MockStoryDelegate()
        sut.storyDelegate = mockStoryDelegate

        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
            XCTFail("Fail to dequeue correct cell")
            return
        }
        
        collectionView.delegate?.collectionView!(collectionView, willDisplay: cell, forItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockStoryDelegate.calledWillDisplayLastStory)
    }
    
    func testSelectCell() {
        let mockStoryDelegate = MockStoryDelegate()
        sut.storyDelegate = mockStoryDelegate
        
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        collectionView.delegate?.collectionView!(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(mockStoryDelegate.selectedStory?.id, "1234")
        XCTAssertEqual(mockStoryDelegate.selectedStory?.title, "Bar")
    }
    
    func testSetStoryViewCellDelegate() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
            XCTFail("Fail to dequeue correct cell")
            return
        }
        
        XCTAssertTrue(cell.delegate is StoriesDataSource)
    }
}

// MARK: -

extension StoriesDataSourceTests {
    
    // MARK: - Mock UICollectionView
    
    class MockCollectionView: UICollectionView {
        
        class func mockCollectionView() -> MockCollectionView {
            let layout = UICollectionViewFlowLayout()
            let mockCollectionView = MockCollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), collectionViewLayout: layout)
            
            mockCollectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: StoryViewCell.reuseIdentifier)
            
            return mockCollectionView
        }
        
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
    }
    
    // MARK: - StoriesDataSource Story Delegate
    
    class MockStoryDelegate: StoriesDataSourceStoryDelegate {
        
        var selectedStory: Story?
        var calledWillDisplayLastStory = false
        
        func willDisplayLastStory() {
            calledWillDisplayLastStory = true
        }
        
        func didSelectStory(_ story: Story) {
            selectedStory = story
        }
    }
}
