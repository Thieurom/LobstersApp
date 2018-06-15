//
//  StoryViewController.swift
//  LobstersApp
//
//  Created by Doan Le Thieu on 6/15/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit
import WebKit

class StoryViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Data
    
    let story: Story
    
    // MARK: - Views
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
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
        
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        loadStory(story)
    }
    
    // MARK: - Private helpers
    
    private func loadStory(_ story: Story) {
        guard let url = story.sourceURL else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
