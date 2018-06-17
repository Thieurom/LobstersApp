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
