//
//  StoriesProvider.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

class StoriesProvider: ArrayDataProvider<StoryViewModel> {

    func index(of storyViewModel: StoryViewModel) -> Int? {
        for (index, storedViewModel) in items.enumerated() {
            guard storedViewModel.story.id == storyViewModel.story.id else {
                continue
            }
            
            return index
        }
        
        return nil
    }
    
    func isLastItem(at indexPath: IndexPath) -> Bool {
        return (indexPath.section == 0) && (indexPath.item == itemsCount - 1)
    }
}
