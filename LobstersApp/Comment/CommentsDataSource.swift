//
//  CommentsDataSource.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class CommentsDataSource: CollectionDataSource<CommentsProvider, CommentViewCell> {
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // temporary size before adding and constrainting Cell's views
        return CGSize(width: 50, height: 50)
    }
}
