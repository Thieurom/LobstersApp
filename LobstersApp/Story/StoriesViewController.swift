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
    
    private let storiesProvider: StoriesProvider
    private let storiesLoader: StoriesLoader
    private var storiesDataSource: StoriesDataSource!
    
    private var isFirstLoad = true
    private var isLoadingNext = false
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        
        return control
    }()
    
    // MARK: - Initializer
    
    init(storiesProvider: StoriesProvider, storiesLoader: StoriesLoader) {
        self.storiesProvider = storiesProvider
        self.storiesLoader = storiesLoader
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
        loadStories()
    }
    
    // MARK: - Private helpers
    
    private func initViews() {
        // navigation item
        let titleLabel = UILabel()
        
        titleLabel.textColor = .bokaraGray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AvenirNext-Heavy", size: 24)
        titleLabel.text = "Lobste.rs".uppercased()
        navigationItem.titleView = titleLabel
        
        // add views
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        
        // constraint views
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    private func setUpViews() {
        collectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: "StoryViewCell")
        
        storiesDataSource = StoriesDataSource()
        storiesDataSource.storiesProvider = storiesProvider
        
        storiesDataSource.storyDelegate = self
        collectionView.dataSource = storiesDataSource
        collectionView.delegate = storiesDataSource
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(StoriesViewController.refreshControlChangedValue), for: .valueChanged)
    }
    
    private func loadStories() {
        if isFirstLoad {
            loadingIndicator.startAnimating()
        }
        
        storiesLoader.storiesForNextPage { [weak self] (result) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.loadingIndicator.stopAnimating()
                strongSelf.refreshControl.endRefreshing()
                
                switch result {
                case let .success(stories):
//                    strongSelf.storiesDataSource.setStories(stories)
                    strongSelf.storiesProvider.set(stories: stories)
                    strongSelf.collectionView.reloadData()
                case .failure:
                    print("Error loading stories.")
                }
            }
        }
    }
    
    private func loadNextStories() {
        guard !isLoadingNext else {
            return
        }
        
        isLoadingNext = true
        
        storiesLoader.storiesForNextPage { [weak self] (result) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case let .success(stories):
                    strongSelf.storiesProvider.append(stories: stories)
                    
                    strongSelf.collectionView.performBatchUpdates({
                        let insertedIndexPaths = stories.compactMap { strongSelf.storiesProvider.index(of: $0) }
                            .map { IndexPath(item: $0, section: 0) }
                        
                        strongSelf.collectionView.insertItems(at: insertedIndexPaths)
                    }, completion: { (_) in
                        strongSelf.isLoadingNext = false
                    })
                case .failure:
                    print("Error loading stories.")
                }
            }
        }
    }
    
    @objc private func refreshControlChangedValue() {
        storiesLoader.resetToFirstPage()
        loadStories()
    }
    
    private func showStoryViewController(with story: Story) {
        let storyViewController = StoryViewController(story: story)
        navigationController?.pushViewController(storyViewController, animated: true)
    }
}

// MARK: - StoriesDataSource Story Delegate

extension StoriesViewController: StoriesDataSourceStoryDelegate {
    
    func willDisplayLastStory() {
        loadNextStories()
    }
    
    func didSelectStory(_ story: Story) {
        guard story.sourceURL != nil else {
            return
        }
        
        showStoryViewController(with: story)
    }
}
