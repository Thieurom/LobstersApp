//
//  CommentViewModel.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct CommentViewModel {
    let comment: Comment
    let username: String
    let timestamp: String
    let commentBody: String
    let indentationLevel: Int
    
    init(comment: Comment) {
        self.comment = comment
        self.username = comment.commenter.name
        self.timestamp = comment.creationDate.timeAgo()
        self.commentBody = comment.htmlComment
        self.indentationLevel = comment.indentationLevel
    }
}
