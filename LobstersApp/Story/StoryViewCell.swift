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
            urlLabel.text = viewModel?.urlString.uppercased() ?? ""
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
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .stack
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .bokaraGray
        
        return label
    }()
    
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
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .bokaraGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setImage(UIImage(named: "comment"), for: .normal)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .bokaraGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setImage(UIImage(named: "share"), for: .normal)
        
        return button
    }()
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .concrete
        
        return view
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
        contentView.addSubview(separatorLineView)
        
        constraintLabels()
        constraintButtons()
        constraintSeparatorLineView()
    }
    
    private func constraintLabels() {
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutMargins = contentView.layoutMarginsGuide
        let urlLabelTop = urlLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor, constant: 12)
        urlLabelTop.priority = UILayoutPriority(999)
        urlLabelTop.isActive = true
        
        NSLayoutConstraint.activate([
            urlLabel.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor, constant: 12),
            urlLabel.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor, constant: -12)])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: urlLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: urlLabel.trailingAnchor)])
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            userLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            userLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 6),
            timeLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor)])
        
        timeLabel.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
        timeLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
    }
    
    private func constraintButtons() {
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shareButton.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            shareButton.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor)])
        
        NSLayoutConstraint.activate([
            commentButton.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -50),
            commentButton.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor)])
    }
    
    private func constraintSeparatorLineView() {
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            separatorLineView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            separatorLineView.leadingAnchor.constraint(equalTo: urlLabel.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: urlLabel.trailingAnchor),
            separatorLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
}
