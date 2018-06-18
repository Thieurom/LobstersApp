//
//  StoriesDataSource.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

protocol StoriesDataSourceStoryDelegate: AnyObject {
    func willDisplayLastStory()
    func didSelectStory(_ story: Story)
}

protocol StoriesDataSourceCellDelegate: AnyObject {
    func storyViewCell(_ cell: StoryViewCell, didPressCommentButton button: UIButton)
    func storyViewCell(_ cell: StoryViewCell, didPressShareButton button: UIButton)
}

class StoriesDataSource: CollectionDataSource<StoriesProvider, StoryViewCell> {
    
    weak var storyDelegate: StoriesDataSourceStoryDelegate?
    weak var cellDelegate: StoriesDataSourceCellDelegate?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let storyViewCell = cell as? StoryViewCell {
            storyViewCell.delegate = self
            return storyViewCell
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let storiesProvider = provider else {
            return
        }
        
        if storiesProvider.isLastItem(at: indexPath) {
            storyDelegate?.willDisplayLastStory()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let storyViewModel = provider?.item(at: indexPath) {
            let story = storyViewModel.story
            storyDelegate?.didSelectStory(story)
        }
    }
}

// MARK: - StoryViewCell Delegate

extension StoriesDataSource: StoryViewCellDelegate {
    
    func storyViewCell(_ cell: StoryViewCell, didPressCommentButton button: UIButton) {
        cellDelegate?.storyViewCell(cell, didPressCommentButton: button)
    }
    
    func storyViewCell(_ cell: StoryViewCell, didPressShareButton button: UIButton) {
        cellDelegate?.storyViewCell(cell, didPressShareButton: button)
    }
}
