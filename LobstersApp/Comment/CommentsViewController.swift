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
    let story: Story
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
    
    init(story: Story, commentsProvider: CommentsProvider) {
        self.story = story
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
        loadComments()
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
    
    private func loadComments() {
        let service = LobstersService()
        
        service.comments(forStoryId: story.id) { [weak self] (result) in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    switch result {
                    case let .success(comments):
                        let commentViewModels = comments.map { CommentViewModel(comment: $0) }
                        strongSelf.commentsProvider.set(items: commentViewModels)
                        strongSelf.collectionView.reloadData()
                        
                    case .failure:
                        print("Error fetching comments")
                    }
                }
            }
        }
    }
}
