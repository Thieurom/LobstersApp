//
//  CollectionDataProvider.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

protocol CollectionDataProvider {
    associatedtype T
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
}
