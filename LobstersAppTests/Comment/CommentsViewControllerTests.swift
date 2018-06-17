//
//  CommentsViewControllerTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class CommentsViewControllerTests: XCTestCase {
    
    var sut: CommentsViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = CommentsViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasCollectionView() {
        XCTAssertTrue(sut.collectionView.isDescendant(of: sut.view))
    }
    
    func testSetCollectionViewDataSource() {
        XCTAssertTrue(sut.collectionView.dataSource is CommentsDataSource)
    }
    
    func testSetCollectionViewDelegate() {
        XCTAssertTrue(sut.collectionView.delegate is CommentsDataSource)
    }
    
    func testCollectionViewDataSourceEqualDelegate() {
        XCTAssertEqual(sut.collectionView.dataSource as? CommentsDataSource, sut.collectionView.delegate as? CommentsDataSource)
    }
}
