//
//  Date+TimeAgo.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

/* https://gist.github.com/minorbug/468790060810e0d29545 */

extension Date {
    
    fileprivate struct Item {
        let multi: String
        let single: String
        let value: Int?
    }
    
    fileprivate var components: DateComponents {
        return Calendar.current.dateComponents(
            [.minute, .hour, .day, .weekOfYear, .month, .year, .second],
            from: self,
            to: Date()
        )
    }
    
    fileprivate var items: [Item] {
        return [
            Item(multi: "years ago", single: "1 year ago", value: components.year),
            Item(multi: "weeks ago", single: "1 week ago", value: components.weekOfYear),
            Item(multi: "months ago", single: "1 month ago", value: components.month),
            Item(multi: "days ago", single: "1 day ago", value: components.day),
            Item(multi: "hours ago", single: "1 hour ago", value: components.hour),
            Item(multi: "minutes ago", single: "1 minute ago", value: components.minute),
            Item(multi: "seconds ago", single: "1 second ago", value: components.second)
        ]
    }
    
    public func timeAgo() -> String {
        for item in items {
            switch item.value {
            case let .some(step) where step == 0:
                continue
            case let .some(step) where step == 1:
                return item.single
            case let .some(step):
                return "\(step) \(item.multi)"
            default:
                continue
            }
        }
        
        return "1 second a go"
    }
}
