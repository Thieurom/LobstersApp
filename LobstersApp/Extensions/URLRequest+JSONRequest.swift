//
//  URLRequest+JSONRequest.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func jsonRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
