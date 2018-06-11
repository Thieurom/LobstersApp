//
//  StoriesViewController.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    
    // MARK: - Data
    
    var storiesDataSource: StoriesDataSource!
    
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
        
        storiesDataSource = StoriesDataSource()
        collectionView.dataSource = storiesDataSource
        collectionView.delegate = storiesDataSource
    }
}
