//
//  URL+AppendingQueries.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

extension URL {
    
    func appendingQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components?.url
    }
}
