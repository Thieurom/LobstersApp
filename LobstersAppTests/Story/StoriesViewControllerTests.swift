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
    
    override func setUp() {
        super.setUp()
        
        let storiesLoader = StoriesLoader(lobstersService: LobstersService())
        
        sut = StoriesViewController(storiesLoader: storiesLoader)
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
}
