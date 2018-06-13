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
    
    private let storiesLoader: StoriesLoader
    private var storiesDataSource: StoriesDataSource!
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - Initializer
    
    init(storiesLoader: StoriesLoader) {
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
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setUpViews() {
        collectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: "StoryViewCell")
        
        storiesDataSource = StoriesDataSource()
        collectionView.dataSource = storiesDataSource
        collectionView.delegate = storiesDataSource
    }
    
    private func loadStories() {
        storiesLoader.storiesForNextPage { [weak self] (result) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case let .success(stories):
                    strongSelf.storiesDataSource.setStories(stories)
                    strongSelf.collectionView.reloadData()
                case .failure:
                    print("Error loading stories.")
                }
            }
        }
    }
}
