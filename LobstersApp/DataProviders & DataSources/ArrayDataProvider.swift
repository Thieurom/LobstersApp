//
//  ArrayDataProvider.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

class ArrayDataProvider<T>: CollectionDataProvider {
    
    private(set) var items = [T]()
    
    var itemsCount: Int {
        return items.count
    }
    
    func set(items: [T]) {
        self.items = items
    }
    
    func append(items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    // MARK: - CollectionView Data Provider
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard section == 0 else {
            return 0
        }
        
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section == 0 && indexPath.item >= 0 && indexPath.item < items.count else {
            return nil
        }
        
        return items[indexPath.item]
    }
}
