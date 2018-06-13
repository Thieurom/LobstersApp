//
//  User.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

struct User {
    var name: String
}

// MARK: - User Decodable

extension User: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name = "username"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
    }
}
