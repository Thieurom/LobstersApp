//
//  LobstersURL.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct LobstersURL {
    
    private static let baseURLString = "https://lobste.rs"
    
    static var popularStories: URL {
        return URL(string: baseURLString)!
    }
    
    static func comments(for storyId: String) -> URL {
        return URL(string: baseURLString + "/s/" + storyId)!
    }
}
