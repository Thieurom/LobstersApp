//
//  LobstersServiceTests.swift
//  LobstersAppTests
//
//  Created by Doan Le Thieu on 6/12/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import XCTest
@testable import LobstersApp

class LobstersServiceTests: XCTestCase {
    
    var sut: LobstersService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPopularStoriesUseCorrectURL() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        sut.popularStories(page: 1234) { (_) in }
        
        guard let request = mockURLSession.caughtRequest else {
            XCTFail("Should catch request")
            return
        }
        
        guard let url = request.url else {
            XCTFail("Request should catch url")
            return
        }
        
        XCTAssertEqual(url.host, "lobste.rs")
        XCTAssertEqual(url.path, "")
        XCTAssertEqual(url.query, "page=1234")
    }
    
    func testPopularStoriesAcceptJSON() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        sut.popularStories(page: 1234) { (_) in }

        guard let request = mockURLSession.caughtRequest else {
            XCTFail("Should catch request")
            return
        }
        
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
    }
    
    func testPopularStoriesSucceedWithStories() {
        let testBundle = Bundle(for: type(of: self))
        
        guard let fileURL = testBundle.url(forResource: "StoriesTestData", withExtension: "json") else {
            fatalError("Error locating test data")
        }
        
        guard let json = try? Data(contentsOf: fileURL) else {
            fatalError("Error reading test data")
        }
        
        let mockURLSession = MockURLSession(data: json, response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        let storiesExpectation = expectation(description: "Stories")
        var stories: [Story]?
        
        sut.popularStories(page: 1) { (result) in
            if case let .success(storiesResult) = result {
                stories = storiesResult
                storiesExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertNotNil(stories)
        }
    }
    
    func testPopularStoriesFailWithInvalidData() {
        let mockURLSession = MockURLSession(data: Data(), response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        let errorExpectation = expectation(description: "Invalid Data Error")
        var error: Error?
        
        sut.popularStories(page: 1) { (result) in
            if case let .failure(storiesError) = result {
                error = storiesError
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(error as? LobstersError, .invalidJSON)
        }
    }
    
    func testPopularStoriesFailWithNilData() {
        let mockURLSession = MockURLSession(data: nil, response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        let errorExpectation = expectation(description: "Nil Data Error")
        var error: Error?
        
        sut.popularStories(page: 1) { (result) in
            if case let .failure(storiesError) = result {
                error = storiesError
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(error as? LobstersError, .nonexistData)
        }
    }
    
    func testPopularStoriesFailWithRequestError() {
        let testBundle = Bundle(for: type(of: self))
        
        guard let fileURL = testBundle.url(forResource: "StoriesTestData", withExtension: "json") else {
            fatalError("Error locating test data")
        }
        
        guard let json = try? Data(contentsOf: fileURL) else {
            fatalError("Error reading test data")
        }
        
        let serverError = NSError(domain: "Request Error", code: 1234, userInfo: nil)
        
        let mockURLSession = MockURLSession(data: json, response: nil, error: serverError)
        sut = LobstersService(session: mockURLSession)
        
        let errorExpectation = expectation(description: "Request Error")
        var error: Error?
        
        sut.popularStories(page: 1) { (result) in
            if case let .failure(storiesError) = result {
                error = storiesError
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(error as? LobstersError, .failedRequest)
        }
    }
    
    func testPopularStoriesFailWithInvalidParameter() {
        let testBundle = Bundle(for: type(of: self))
        
        guard let fileURL = testBundle.url(forResource: "StoriesTestData", withExtension: "json") else {
            fatalError("Error locating test data")
        }
        
        guard let json = try? Data(contentsOf: fileURL) else {
            fatalError("Error reading test data")
        }
        
        let mockURLSession = MockURLSession(data: json, response: nil, error: nil)
        sut = LobstersService(session: mockURLSession)
        
        let errorExpectation = expectation(description: "Invalid Parameter Error")
        var error: Error?
        
        sut.popularStories(page: 0) { (result) in
            if case let .failure(storiesError) = result {
                error = storiesError
                errorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(error as? LobstersError, .invalidParameter)
        }
    }
}

// MARK: -

extension LobstersServiceTests {
    
    // MARK: - Mock URLSession
    
    class MockURLSession: URLSession {
        private let dataTask: MockURLSessionDataTask
        var caughtRequest: URLRequest?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            dataTask = MockURLSessionDataTask(data: data, response: response, error: error)
        }

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            caughtRequest = request
            dataTask.completionHandler = completionHandler
            
            return dataTask
        }
    }
    
    // MARK: - Mock URLDataTask
    
    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        // swiftlint:disable:next nesting
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = response
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}
