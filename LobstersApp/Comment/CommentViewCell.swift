//
//  CommentViewCell.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/18/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class CommentViewCell: UICollectionViewCell, ViewModelizedCell {
    
    // MARK: - Data
    
    var viewModel: CommentViewModel? {
        didSet {
            userLabel.text = viewModel?.username ?? ""
            timeLabel.text = viewModel?.timestamp ?? ""
            commentTextView.text = viewModel?.commentBody ?? ""
        }
    }
    
    // MARK: - Subviews
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
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
        contentView.addSubview(userLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(commentTextView)
    }
}
