//
//  CommitsDataControllerTests.swift
//  GithubSampleAppTests
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import XCTest
import RxSwift

@testable import GithubSampleApp

class CommitsDataControllerTests: XCTestCase {
    
    var mockNetworkClient: MockNetworkClient!
    var subject: CommitsDataController!

    override func setUp() {
        mockNetworkClient = MockNetworkClient()
        subject = CommitsDataController(networkClient: mockNetworkClient)
    }
    
    func testLoadCommits() {
        _ = subject.loadCommits(from: "apple/swift")
        XCTAssertTrue(mockNetworkClient.executeDataRequestCalled)
        let url = URL(string: "https://api.github.com/repos/apple/swift/commits")!
        XCTAssertEqual(url, mockNetworkClient.request?.url)
    }
}


class MockNetworkClient: NetworkClient {
    var executeDataRequestCalled = false
    var request: URLRequest?
    
    func executeDataRequest<T>(request: URLRequest) -> Observable<T> where T : Decodable {
        executeDataRequestCalled = true
        self.request = request
        return Observable.never()
    }
}
