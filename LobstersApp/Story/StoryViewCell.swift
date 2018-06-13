//
//  StoryViewCell.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class StoryViewCell: UICollectionViewCell {
    
    // MARK: - Data
    
    var viewModel: StoryViewModel? {
        didSet {
            urlLabel.text = viewModel?.urlString ?? ""
            titleLabel.text = viewModel?.title ?? ""
            userLabel.text = viewModel?.username ?? ""
            timeLabel.text = viewModel?.timestamp ?? ""
            
            if let count = viewModel?.commentCount, count > 0 {
                commentButton.setTitle("\(count)", for: .normal)
            } else {
                commentButton.setTitle("", for: .normal)
            }
        }
    }
    
    // MARK: - Sub views
    
    lazy var urlLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
    
    // MARK: - Private helpers
    
    private func initSubviews() {
        contentView.addSubview(urlLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(userLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
    }
}
