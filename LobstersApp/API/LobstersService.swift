//
//  LobstersService.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

class LobstersService {
    
    private let session: URLSession
    
    init(session: URLSession = defaultSession()) {
        self.session = session
    }
    
    class func defaultSession() -> URLSession {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        return session
    }
    
    func popularStories(page: Int) {
        guard page > 0 else {
            return
        }
        
        let queries = [
            "page": "\(page)"
        ]
        
        guard let url = LobstersURL.popularStories.appendingQueries(queries) else {
            return
        }
        
        let request = URLRequest.jsonRequest(url: url)
        session.dataTask(with: request) { (_, _, _) in
            //
        }
    }
}
