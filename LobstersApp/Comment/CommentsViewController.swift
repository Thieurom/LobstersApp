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
    var commentsLoader: LobstersService!
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
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
        commentsLoader = LobstersService()
        loadComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
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
        // navigation title
        let titleLabel = UILabel()
        
        titleLabel.textColor = .bokaraGray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "Comments"
        navigationItem.titleView = titleLabel
        navigationController?.isNavigationBarHidden = false
        
        // collection view
        collectionView.register(StoryViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: StoryViewCell.reuseIdentifier)
        collectionView.register(CommentViewCell.self, forCellWithReuseIdentifier: CommentViewCell.reuseIdentifier)
        
        commentsDataSource = CommentsDataSource()
        commentsDataSource.headerViewModel = StoryViewModel(story: story)
        commentsDataSource.provider = commentsProvider
        commentsDataSource.cellDelegate = self
        
        collectionView.dataSource = commentsDataSource
        collectionView.delegate = commentsDataSource
    }
    
    private func loadComments() {
        commentsLoader.comments(forStoryId: story.id) { [weak self] (result) in
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

// MARK: - StoriesDataSource Cell Delegate

extension CommentsViewController: StoriesDataSourceCellDelegate {
    
    func storyViewCell(_ cell: StoryViewCell, didPressCommentButton button: UIButton) {
    }
    
    func storyViewCell(_ cell: StoryViewCell, didPressShareButton button: UIButton) {
        var sharedContent = "\(story.title)"
        if let url = story.sourceURL {
            sharedContent += " - \(url.absoluteString)"
        }
        
        let activityController = UIActivityViewController(activityItems: [sharedContent], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
}
