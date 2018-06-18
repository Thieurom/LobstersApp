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
    
    private let commentsProvider: CommentsProvider
    private var commentsDataSource: CommentsDataSource!
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - Initializers
    
    init(commentsProvider: CommentsProvider) {
        self.commentsProvider = commentsProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        setUpViews()
    }
    
    // MARK: - Private helpers
    
    private func initViews() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setUpViews() {
        collectionView.register(CommentViewCell.self, forCellWithReuseIdentifier: CommentViewCell.reuseIdentifier)
        
        commentsDataSource = CommentsDataSource()
        commentsDataSource.provider = commentsProvider
        collectionView.dataSource = commentsDataSource
        collectionView.delegate = commentsDataSource
    }
}
