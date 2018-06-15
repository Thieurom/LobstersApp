//
//  StoriesProvider.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

class StoriesProvider: CollectionViewDataProvider {
    
    private var stories = [Story]()
    
    var storiesCount: Int {
        return stories.count
    }
    
    func set(stories: [Story]) {
        self.stories = stories
    }
    
    func append(stories: [Story]) {
        self.stories.append(contentsOf: stories)
    }
    
    func index(of story: Story) -> Int? {
        for (index, storedStory) in stories.enumerated() {
            guard storedStory.id == story.id else {
                continue
            }
            
            return index
        }
        
        return nil
    }
    
    func isLastItem(at indexPath: IndexPath) -> Bool {
        return (indexPath.section == 0) && (indexPath.item == stories.count - 1)
    }
    
    // MARK: - Stories Collection Provider
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard section == 0 else {
            return 0
        }
        
        return stories.count
    }
    
    func item(at indexPath: IndexPath) -> Story? {
        guard indexPath.section == 0 && indexPath.item >= 0 && indexPath.item < stories.count else {
            return nil
        }
        
        return stories[indexPath.item]
    }
}
