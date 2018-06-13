//
//  StoryViewModel.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct StoryViewModel {
    let story: Story
    let title: String
    let urlString: String
    let username: String
    let timestamp: String
    let commentCount: Int
    
    init(story: Story) {
        self.story = story
        self.title = story.title
        
        if let host = story.sourceURL?.host {
            if host.hasPrefix("www.") {
                self.urlString = String(host.dropFirst(4))
            } else {
                self.urlString = host
            }
        } else {
            self.urlString = "ask"
        }
        
        self.username = story.submitter.name
        self.timestamp = story.creationDate.timeAgo()
        self.commentCount = story.commentCount
    }
}
