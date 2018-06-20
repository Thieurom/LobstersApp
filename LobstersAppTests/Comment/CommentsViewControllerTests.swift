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
        
        let user = User(name: "")
        let story = Story(id: "", title: "", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
        let commentsProvider = CommentsProvider()
        
        sut = CommentsViewController(story: story, commentsProvider: commentsProvider)
        sut.loadViewIfNeeded()
        sut.commentsLoader = FakeLobstersService()
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
    
//    func testPressShareButtonOnHeaderView() {
//        let collectionView = sut.collectionView
//        collectionView.reloadData()
//        collectionView.layoutIfNeeded()
//        
//        guard let headerView = collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
//            XCTFail("Fail to get header view")
//            return
//        }
//        
//        headerView.delegate?.storyViewCell(headerView, didPressShareButton: headerView.shareButton)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
//            XCTAssertNotNil(self.sut.presentedViewController)
//            XCTAssertTrue(self.sut.presentedViewController is UIActivityViewController)
//        }
//    }
}

// MAKR: -

extension CommentsViewControllerTests {
    
    // MARK: - Fake Lobsters Service
    
    class FakeLobstersService: LobstersService {
        
        override func comments(forStoryId storyId: String, completion: @escaping (CommentsResult) -> Void) {
            completion(.success([]))
        }
    }
}
