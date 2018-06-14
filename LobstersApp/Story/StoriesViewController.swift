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
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        return indicator
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
        collectionView.dataSource = storiesDataSource
        collectionView.delegate = storiesDataSource
    }
    
    private func loadStories() {
        loadingIndicator.startAnimating()
        
        storiesLoader.storiesForNextPage { [weak self] (result) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.loadingIndicator.stopAnimating()
                
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
