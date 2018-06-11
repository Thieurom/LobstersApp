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
