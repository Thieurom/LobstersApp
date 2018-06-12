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
        
        sut = StoriesViewController()
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
}
