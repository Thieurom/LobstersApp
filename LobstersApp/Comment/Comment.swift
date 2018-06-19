//
//  Comment.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct Comment {
    var id: String
    var creationDate: Date
    var commenter: User
    var indentationLevel: Int
    var htmlComment: String
}

extension Comment: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "short_id"
        case creationDate = "created_at"
        case commenter = "commenting_user"
        case indentationLevel = "indent_level"
        case htmlComment = "comment"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        
        let dateString = try values.decode(String.self, forKey: .creationDate)
        let dateFormatter = DateFormatter.iso8601Full
        
        if let date = dateFormatter.date(from: dateString) {
            self.creationDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .creationDate, in: values, debugDescription: "Data string does not match format expected by formatter.")
        }
        
        self.creationDate = try values.decode(Date.self, forKey: .creationDate)
        self.commenter = try values.decode(User.self, forKey: .commenter)
        self.indentationLevel = try values.decode(Int.self, forKey: .indentationLevel)
        self.htmlComment = try values.decode(String.self, forKey: .htmlComment)
    }
}

// MARK: - CommentList

struct CommentList {
    let comments: [Comment]
}

extension CommentList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case comments
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.comments = try values.decode(Array<Comment>.self, forKey: .comments)
    }
}
