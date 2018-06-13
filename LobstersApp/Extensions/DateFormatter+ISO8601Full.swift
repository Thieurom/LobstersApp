//
//  DateFormatter+ISO8601Full.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
}
