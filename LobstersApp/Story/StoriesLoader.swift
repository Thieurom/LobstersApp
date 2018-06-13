//
//  StoriesLoader.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

class StoriesLoader {
    
    private let service: LobstersService
    private(set) var nextPage = 1
    private var isLoading = false
    
    init(lobstersService: LobstersService) {
        self.service = lobstersService
    }
    
    func storiesForNextPage(completion: @escaping (StoriesResult) -> Void) {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        service.popularStories(page: nextPage) { [weak self] (result) in
            if let strongSelf = self {
                strongSelf.nextPage += 1
                strongSelf.isLoading = false
                completion(result)
            }
        }
    }
    
    func resetToFirstPage() {
        nextPage = 1
    }
}
