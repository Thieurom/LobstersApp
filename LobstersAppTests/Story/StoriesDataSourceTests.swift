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
    var controller: StoriesViewController!
    var story: Story!
    
    override func setUp() {
        super.setUp()
        
        sut = StoriesDataSource()
        
        let storiesLoader = StoriesLoader(lobstersService: LobstersService())
        controller = StoriesViewController(storiesLoader: storiesLoader)
        controller.loadViewIfNeeded()
        
        collectionView = controller.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = sut
        
        let user = User(name: "Foo")
        story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
    }
    
    override func tearDown() {
        sut.setStories([])
        
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
    
    func testNumbewOfItems() {
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 0)
        
        sut.setStories([story])
        collectionView.reloadData()
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func testCellForItemReturnStoryViewCell() {
        sut.setStories([story])
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(cell is StoryViewCell)
    }
    
    func testCellForItemDequeueFromCollectionView() {
        let mockCollectionView = MockCollectionView.mockCollectionView()
        mockCollectionView.dataSource = sut
        
        sut.setStories([story])
        mockCollectionView.reloadData()
        mockCollectionView.layoutIfNeeded()
        
        _ = mockCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockCollectionView.cellGotDequeued)
    }
}

// MARK: -

extension StoriesDataSourceTests {
    
    // MARK: - Mock UICollectionView
    
    class MockCollectionView: UICollectionView {
        
        class func mockCollectionView() -> MockCollectionView {
            let layout = UICollectionViewFlowLayout()
            let mockCollectionView = MockCollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), collectionViewLayout: layout)
            
            mockCollectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: "StoryViewCell")
            
            return mockCollectionView
        }
        
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
    }
}
