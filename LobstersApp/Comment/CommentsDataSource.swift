//
//  CommentsDataSource.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class CommentsDataSource: CollectionDataSource<CommentsProvider, CommentViewCell> {
    
    var headerViewModel: StoryViewModel?
    weak var cellDelegate: StoriesDataSourceCellDelegate?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader,
            let viewModelForHeader = headerViewModel,
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: StoryViewCell.reuseIdentifier, for: indexPath) as? StoryViewCell else {
                return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        
        headerView.viewModel = viewModelForHeader
        
        // hide comment button
        headerView.commentButton.isEnabled = false
        headerView.commentButton.isHidden = true
        
        headerView.delegate = self
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let viewModelForHeader = headerViewModel else {
            return super.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
        }
        
        let sizingCell = StoryViewCell()
        let width = collectionView.frame.size.width
        sizingCell.contentView.frame.size.width = width
        
        sizingCell.viewModel = viewModelForHeader
        
        sizingCell.contentView.setNeedsLayout()
        sizingCell.contentView.layoutIfNeeded()
        
        let height = sizingCell.contentView.systemLayoutSizeFitting(CGSize(width: width, height: UILayoutFittingCompressedSize.height)).height
        
        sizingCell.prepareForReuse()
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - StoryViewCell Delegate

extension CommentsDataSource: StoryViewCellDelegate {
    
    func storyViewCell(_ cell: StoryViewCell, didPressCommentButton button: UIButton) {
        cellDelegate?.storyViewCell(cell, didPressCommentButton: button)
    }
    
    func storyViewCell(_ cell: StoryViewCell, didPressShareButton button: UIButton) {
        cellDelegate?.storyViewCell(cell, didPressShareButton: button)
    }
}
