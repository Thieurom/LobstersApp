//
//  CommentViewCellTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class CommentViewCellTests: XCTestCase {
    
    var cell: CommentViewCell!
    var date: Date!
    var commentViewModel: CommentViewModel!
    
    override func setUp() {
        super.setUp()
        
        let user = User(name: "Foo")
        let story = Story(id: "", title: "", sourceURL: nil, creationDate: Date(), submitter: user, commentCount: 0)
        let commentsProvider = CommentsProvider()
        let controller = CommentsViewController(story: story, commentsProvider: commentsProvider)
        controller.loadViewIfNeeded()
        
        date = Date()
        let comment = Comment(id: "", creationDate: date, commenter: user, indentationLevel: 1, htmlComment: "<p>comment</p>")
        commentViewModel = CommentViewModel(comment: comment)
        
        commentsProvider.set(items: [commentViewModel])
        
        let collectionView = controller.collectionView
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        guard let commentViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentViewCell.reuseIdentifier, for: IndexPath(item: 0, section: 0)) as? CommentViewCell else {
            fatalError()
        }
        
        cell = commentViewCell
        commentViewModel = CommentViewModel(comment: comment)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasUserLabel() {
        XCTAssertTrue(cell.userLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasTimeLabel() {
        XCTAssertTrue(cell.timeLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasCommentTextView() {
        XCTAssertTrue(cell.commentTextView.isDescendant(of: cell.contentView))
    }
    
    func testSetCommentViewModelSetUserLabel() {
        cell.viewModel = commentViewModel
        
        XCTAssertEqual(cell.userLabel.text, "Foo")
    }
    
    func testSetCommentViewModelSetTimeLabel() {
        cell.viewModel = commentViewModel
        
        XCTAssertEqual(cell.timeLabel.text, date.timeAgo())
    }
    
    func testSetCommentViewModelSetCommentTextView() {
        cell.viewModel = commentViewModel
        
        XCTAssertEqual(cell.commentTextView.text, "<p>comment</p>")
    }
}
