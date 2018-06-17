//
//  CommentsViewController.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    // MARK: - Data
    
    private var commentsDataSource: CommentsDataSource!
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        commentsDataSource = CommentsDataSource()
        collectionView.dataSource = commentsDataSource
        collectionView.delegate = commentsDataSource
    }
}
