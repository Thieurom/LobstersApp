//
//  CommentsProviderTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class CommentsProviderTests: XCTestCase {
    
    var sut: CommentsProvider!
    var commentViewModel: CommentViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = CommentsProvider()
        let user = User(name: "Foo")
        let comment = Comment(id: "", creationDate: Date(), commenter: user, indentationLevel: 1, htmlComment: "")
        commentViewModel = CommentViewModel(comment: comment)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetComments() {
        sut.set(items: [commentViewModel])
        
        XCTAssertEqual(sut.itemsCount, 1)
    }
    
    func testAppendComments() {
        sut.append(items: [commentViewModel])
        
        XCTAssertEqual(sut.itemsCount, 1)
    }
}
