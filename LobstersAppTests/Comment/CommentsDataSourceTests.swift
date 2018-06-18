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
        let commentsProvider = CommentsProvider()
        sut.provider = commentsProvider

        let controller = CommentsViewController(commentsProvider: commentsProvider)
        controller.loadViewIfNeeded()
        
        collectionView = controller.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = sut
        
        let user = User(name: "")
        let comment = Comment(id: "1234", creationDate: Date(), commenter: user, indentationLevel: 1, htmlComment: "")
        let commentViewModel = CommentViewModel(comment: comment)
        
        commentsProvider.set(items: [commentViewModel])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
    
    func testNumberOfItems() {
        collectionView.reloadData()
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func testCellForItemReturnCommentViewCell() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(cell is CommentViewCell)
    }
    
    func testCellForItemDequeuedFromCollectionView() {
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
        
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CommentViewCell else {
            XCTFail("Fail to dequeue correct cell")
            return
        }
        
        XCTAssertNotNil(cell.viewModel)
        XCTAssertEqual(cell.viewModel?.comment.id, "1234")
    }
}

// MARK: -

extension CommentsDataSourceTests {
    
    // MARK: - Mock UICollectionView
    
    class MockCollectionView: UICollectionView {
        
        class func mockCollectionView() -> MockCollectionView {
            let layout = UICollectionViewFlowLayout()
            let mockCollectionView = MockCollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), collectionViewLayout: layout)
            
            mockCollectionView.register(CommentViewCell.self, forCellWithReuseIdentifier: CommentViewCell.reuseIdentifier)
            
            return mockCollectionView
        }
        
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
    }
}
