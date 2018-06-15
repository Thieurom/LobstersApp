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

protocol CollectionViewDataProvider {
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func item(at indexPath: IndexPath) -> Story?
}

class StoriesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Property
    
    var storiesProvider: StoriesProvider?
    private let sizingCell = StoryViewCell()
    weak var storyDelegate: StoriesDataSourceStoryDelegate?
    
    // MARK: - UICollectionView Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let storiesProvider = storiesProvider else {
            return 0
        }
        
        return storiesProvider.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let storiesProvider = storiesProvider else {
            return 0
        }
        
        return storiesProvider.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewCell", for: indexPath) as? StoryViewCell else {
            fatalError()
        }
        
//        let story = stories[indexPath.item]
        if let story = storiesProvider?.item(at: indexPath) {
            let storyViewModel = StoryViewModel(story: story)
            cell.viewModel = storyViewModel
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let storiesProvider = storiesProvider else {
            return
        }
        
        if storiesProvider.isLastItem(at: indexPath) {
            storyDelegate?.willDisplayLastStory()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let story = storiesProvider?.item(at: indexPath) {
            storyDelegate?.didSelectStory(story)
        }
    }
    
    // MARK: - UICollectionView Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let story = storiesProvider?.item(at: indexPath) else {
            return CGSize.zero
        }
        
        let width = collectionView.frame.size.width
        sizingCell.contentView.frame.size.width = width

//        let story = stories[indexPath.item]
        let storyViewModel = StoryViewModel(story: story)
        sizingCell.viewModel = storyViewModel

        sizingCell.contentView.setNeedsLayout()
        sizingCell.contentView.layoutIfNeeded()

        let height = sizingCell.contentView.systemLayoutSizeFitting(CGSize(width: width, height: UILayoutFittingCompressedSize.height)).height

        sizingCell.prepareForReuse()
        
        return CGSize(width: width, height: height)
    }
}
