//
//  CommentTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class CommentTests: XCTestCase {
    
    var user: User!
    
    override func setUp() {
        super.setUp()
        
        user = User(name: "Bar")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasId() {
        let comment = Comment(id: "1234", creationDate: Date(), commenter: user, indentationLevel: 1, htmlComment: "")
        
        XCTAssertEqual(comment.id, "1234")
    }
    
    func testHasCreationDate() {
        let date = Date()
        let comment = Comment(id: "", creationDate: date, commenter: user, indentationLevel: 1, htmlComment: "")
        
        XCTAssertEqual(comment.creationDate, date)
    }
    
    func testHasCommenter() {
        let comment = Comment(id: "", creationDate: Date(), commenter: user, indentationLevel: 1, htmlComment: "")
        
        XCTAssertEqual(comment.commenter.name, user.name)
    }
    
    func testHasIndentationLevel() {
        let comment = Comment(id: "", creationDate: Date(), commenter: user, indentationLevel: 2, htmlComment: "")
        
        XCTAssertEqual(comment.indentationLevel, 2)
    }
    
    func testHasHTMLComment() {
        let comment = Comment(id: "", creationDate: Date(), commenter: user, indentationLevel: 1, htmlComment: "<p>Comment</p>")
        
        XCTAssertEqual(comment.htmlComment, "<p>Comment</p>")
    }
}
