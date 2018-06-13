//
//  Story.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct Story {
    var id: String
    var title: String
    var sourceURL: URL?
    var creationDate: Date
    var submitter: User
    var commentCount: Int
}

// MARK: - Story Decodable

extension Story: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "short_id"
        case title = "title"
        case sourceURL = "url"
        case creationDate = "created_at"
        case submitter = "submitter_user"
        case commentCount = "comment_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.sourceURL = try? values.decode(URL.self, forKey: .sourceURL)
        
        let dateString = try values.decode(String.self, forKey: .creationDate)
        let dateFormatter = DateFormatter.iso8601Full
        
        if let date = dateFormatter.date(from: dateString) {
            self.creationDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .creationDate, in: values, debugDescription: "Date string does not match format expected by formatter.")
        }
        
        self.creationDate = try values.decode(Date.self, forKey: .creationDate)
        self.submitter = try values.decode(User.self, forKey: .submitter)
        self.commentCount = try values.decode(Int.self, forKey: .commentCount)
    }
}
