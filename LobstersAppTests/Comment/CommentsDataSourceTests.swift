//
//  CommentsDataSourceTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class CommentsDataSourceTests: XCTestCase {
    
    var sut: CommentsDataSource!
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        sut = CommentsDataSource()
        
        let controller = CommentsViewController()
        controller.loadViewIfNeeded()
        
        collectionView = controller.collectionView
        collectionView.dataSource = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
}
