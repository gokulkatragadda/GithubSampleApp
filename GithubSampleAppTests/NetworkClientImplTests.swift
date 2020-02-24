//
//  NetworkClientImplTests.swift
//  GithubSampleAppTests
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import XCTest
import RxSwift

@testable import GithubSampleApp

class NetworkClientImplTests: XCTestCase {
    var subject: NetworkClientImpl!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        mockURLSession = MockURLSession()
        subject = NetworkClientImpl(urlSession: mockURLSession)
    }
    
    func testWhenExecutindDataTaskShouldCallURLSession() {
        let request = URLRequest(url: URL(string: "www.google.com")!)
        let _: Observable<String> = subject.executeDataRequest(request: request)
        XCTAssertTrue(mockURLSession.dataTaskCalled)
        XCTAssertEqual(request.url, mockURLSession.request?.url)
    }
    
}


class MockURLSession: URLSessionType {
    var dataTaskCalled = false
    var request: URLRequest?
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCalled = true
        self.request = request
        return URLSession.shared.dataTask(with: URL(string: "www.google.com")!)
    }
}
