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
            
            if let viewModel = viewModel {
                let comment = viewModel.commentBody.trimmingCharacters(in: .whitespacesAndNewlines)
                let formatting = "<style>body{font: 15px -apple-system;} blockquote{color: #7f7f7f; font-style: italic;}</style>"
                let attributedComment = (formatting + comment).htmlAttributedString()
                
                commentTextView.attributedText = attributedComment
            } else {
                commentTextView.attributedText = NSAttributedString()
            }
            
            userLabelLeading.constant = (viewModel == nil) ? 12 : CGFloat(viewModel!.indentationLevel * 12)
        }
    }
    
    var userLabelLeading: NSLayoutConstraint!
    
    // MARK: - Subviews
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .stack
        
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
        
        constraintSubviews()
    }
    
    private func constraintSubviews() {
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutMargins = contentView.layoutMarginsGuide
        let userLabelTop = userLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor, constant: 6)
        userLabelTop.priority = UILayoutPriority(999)
        userLabelTop.isActive = true
        
        userLabelLeading = userLabel.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor)
        userLabelLeading.constant = 12
        userLabelLeading.isActive = true
        
        userLabel.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor, constant: -12).isActive = true
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 6),
            commentTextView.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor)])
        
        // remove paddings
        commentTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: -24, right: 0)
        commentTextView.textContainer.lineFragmentPadding = 0
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 6),
            timeLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor, constant: -6)])
    }
}
