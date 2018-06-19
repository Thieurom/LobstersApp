//
//  String+HTMLAttributedString.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/19/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        let htmlData = self.data(using: .utf8)!
        
        return try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
