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
}

class StoriesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
    private var stories = [Story]()
    private let sizingCell = StoryViewCell()
    
    weak var storyDelegate: StoriesDataSourceStoryDelegate?
    
    // MARK: - Public methods
    
    func setStories(_ stories: [Story]) {
        self.stories = stories
    }
    
    func appendStories(_ stories: [Story]) {
        self.stories.append(contentsOf: stories)
    }
    
    func indexForStory(_ story: Story) -> Int? {
        for (index, storedStory) in stories.enumerated() {
            guard storedStory.id == story.id else {
                continue
            }
            
            return index
        }
        
        return nil
    }
    
    // MARK: - UICollectionView Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewCell", for: indexPath) as? StoryViewCell else {
            fatalError()
        }
        
        let story = stories[indexPath.item]
        let storyViewModel = StoryViewModel(story: story)
        cell.viewModel = storyViewModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == stories.count - 1 {
            storyDelegate?.willDisplayLastStory()
        }
    }
    
    // MARK: - UICollectionView Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        sizingCell.contentView.frame.size.width = width

        let story = stories[indexPath.item]
        let storyViewModel = StoryViewModel(story: story)
        sizingCell.viewModel = storyViewModel

        sizingCell.contentView.setNeedsLayout()
        sizingCell.contentView.layoutIfNeeded()

        let height = sizingCell.contentView.systemLayoutSizeFitting(CGSize(width: width, height: UILayoutFittingCompressedSize.height)).height

        sizingCell.prepareForReuse()
        
        return CGSize(width: width, height: height)
    }
}
