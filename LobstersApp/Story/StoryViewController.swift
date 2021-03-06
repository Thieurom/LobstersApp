//
//  StoryViewController.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit
import WebKit

class StoryViewController: UIViewController {
    
    // MARK: - Data
    
    let story: Story
    
    // MARK: - Views
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        return indicator
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
    
    // MARK: - Initializers
    
    init(story: Story) {
        self.story = story
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTitleView()
        setUpWebView()
        setUpButtons()
        loadStory(story)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - Private helpers
    
    private func setUpTitleView() {
        let titleLabel = UILabel()
        
        titleLabel.textColor = .bokaraGray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        var text = ""
        
        if let host = story.sourceURL?.host {
            if host.hasPrefix("www.") {
                text = String(host.dropFirst(4))
            } else {
                text = host
            }
        }
        
        titleLabel.text = text.uppercased()
        navigationItem.titleView = titleLabel
    }
    
    private func setUpWebView() {
        view.addSubview(webView)
        view.addSubview(loadingIndicator)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        webView.navigationDelegate = self
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    private func setUpButtons() {
        let toolbar = UIToolbar()
        toolbar.tintColor = .bokaraGray
        view.addSubview(toolbar)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolbar.heightAnchor.constraint(equalToConstant: 44),
            toolbar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        commentButton.setTitle("\(story.commentCount)", for: .normal)
        
        //
        commentButton.addTarget(self, action: #selector(StoryViewController.commentButtonPressed), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(StoryViewController.shareButtonPressed), for: .touchUpInside)
        
        let commentBarButtonItem = UIBarButtonItem(customView: commentButton)
        let shareBarButtonItem = UIBarButtonItem(customView: shareButton)
        toolbar.setItems([commentBarButtonItem, shareBarButtonItem], animated: false)
    }
    
    @objc private func shareButtonPressed() {
        var sharedContent = "\(story.title)"
        if let url = story.sourceURL {
            sharedContent += " - \(url.absoluteString)"
        }
        
        let activityController = UIActivityViewController(activityItems: [sharedContent], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
    
    @objc private func commentButtonPressed() {
        showCommentsViewController(with: story)
    }
    
    private func loadStory(_ story: Story) {
        guard let url = story.sourceURL else {
            return
        }
        
        let request = URLRequest(url: url)
        loadingIndicator.startAnimating()
        webView.load(request)
    }
    
    private func showCommentsViewController(with story: Story) {
        let commentsProvider = CommentsProvider()
        let commentsViewController = CommentsViewController(story: story, commentsProvider: commentsProvider)
        
        navigationController?.pushViewController(commentsViewController, animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension StoryViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }
}
