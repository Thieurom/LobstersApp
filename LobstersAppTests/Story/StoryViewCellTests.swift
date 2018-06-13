//
//  StoryViewCellTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/13/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class StoryViewCellTests: XCTestCase {
    
    var cell: StoryViewCell!
    var date: Date!
    var storyViewModel: StoryViewModel!
    
    override func setUp() {
        super.setUp()
        
        let fakeStoriesLoader = FakeStoriesLoader()
        let homeViewController = StoriesViewController(storiesLoader: fakeStoriesLoader)
        homeViewController.loadViewIfNeeded()
        
        let collectionView = homeViewController.collectionView
        let fakeStoriesDataSource = FakeStoriesDataSource()
        collectionView.dataSource = fakeStoriesDataSource
        collectionView.delegate = fakeStoriesDataSource
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        guard let storyViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewCell", for: IndexPath(item: 0, section: 0)) as? StoryViewCell else {
            fatalError()
        }
        
        cell = storyViewCell
        
        let user = User(name: "Foo")
        date = Date()
        let url = URL(string: "http://www.example.com")!
        let story = Story(id: "", title: "Bar", sourceURL: url, creationDate: date, submitter: user, commentCount: 1)
        storyViewModel = StoryViewModel(story: story)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasURLLabel() {
        XCTAssertTrue(cell.urlLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasTitleLabel() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasUserLabel() {
        XCTAssertTrue(cell.userLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasTimeLabel() {
        XCTAssertTrue(cell.timeLabel.isDescendant(of: cell.contentView))
    }
    
    func testHasCommentButton() {
        XCTAssertTrue(cell.commentButton.isDescendant(of: cell.contentView))
    }
    
    func testHasShareButton() {
        XCTAssertTrue(cell.shareButton.isDescendant(of: cell.contentView))
    }
    
    func testSetStoryViewModelSetURLLabel() {
        cell.viewModel = storyViewModel
        
        XCTAssertEqual(cell.urlLabel.text, "example.com")
    }
    
    func testSetStoryViewModelSetTitleLabel() {
        cell.viewModel = storyViewModel
        
        XCTAssertEqual(cell.titleLabel.text, "Bar")
    }
    
    func testSetStoryViewModelSetUserLabel() {
        cell.viewModel = storyViewModel
        
        XCTAssertEqual(cell.userLabel.text, "Foo")
    }
    
    func testSetStoryViewModelSetTimeLabel() {
        cell.viewModel = storyViewModel
        
        XCTAssertEqual(cell.timeLabel.text, date.timeAgo())
    }
    
    func testSetStoryViewModelSetCommentButton() {
        cell.viewModel = storyViewModel
        
        XCTAssertEqual(cell.commentButton.title(for: .normal), "1")
    }
}

// MARK: -

extension StoryViewCellTests {
    
    // MARK: - Fake Stories Loader
    
    class FakeStoriesLoader: StoriesLoader {
        
        init() {
            super.init(lobstersService: LobstersService())
        }
        
        override func storiesForNextPage(completion: @escaping (StoriesResult) -> Void) {
            completion(.success([]))
        }
    }
    
    // MARK: - Fake Stories Data Source
    
    class FakeStoriesDataSource: StoriesDataSource {
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewCell", for: indexPath) as? StoryViewCell else {
                fatalError()
            }
            
            return cell
        }
    }
}
