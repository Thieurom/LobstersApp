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
    
    override func setUp() {
        super.setUp()
        
        sut = StoriesDataSource()
        controller = StoriesViewController()
        controller.loadViewIfNeeded()
        
        collectionView = controller.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
    
    func testNumbewOfItems() {
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 0)
        
        let user = User(name: "Foo")
        let story = Story(id: "", title: "Bar", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
        
        sut.setStories([story])
        collectionView.reloadData()
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
}
