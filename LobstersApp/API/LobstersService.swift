//
//  LobstersService.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

enum StoriesResult {
    case success([Story])
    case failure(Error)
}

enum LobstersError: Error {
    case invalidParameter
    case nonexistData
    case invalidJSON
    case failedRequest
}

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
    
    func popularStories(page: Int, completion: @escaping (StoriesResult) -> Void) {
        guard page > 0 else {
            completion(.failure(LobstersError.invalidParameter))
            return
        }
        
        let queries = [
            "page": "\(page)"
        ]
        
        guard let url = LobstersURL.popularStories.appendingQueries(queries) else {
            completion(.failure(LobstersError.invalidParameter))
            return
        }
        
        let request = URLRequest.jsonRequest(url: url)
        
        session.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completion(.failure(LobstersError.failedRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(LobstersError.nonexistData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(.iso8601Full)
            
            if let stories = try? jsonDecoder.decode(Array<Story>.self, from: data) {
                completion(.success(stories))
                return
            } else {
                completion(.failure(LobstersError.invalidJSON))
                return
            }
        }
        .resume()
    }
}
