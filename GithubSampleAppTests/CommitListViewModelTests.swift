//
//  CommitListViewModelTests.swift
//  GithubSampleAppTests
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import XCTest
import RxSwift
@testable import GithubSampleApp

class CommitListViewModelTests: XCTestCase {
    var mockDataController: MockCommitsDataController!
    var subject: CommitListViewModel!

    override func setUp() {
        mockDataController = MockCommitsDataController()
        subject = CommitListViewModel(dataController: mockDataController)
    }

    func testLoadCommitsShouldLoadFromDataController() {
        _ = subject.loadCommits(repoName: "apple/swift")
        XCTAssertEqual("apple/swift", mockDataController.repoName)
        XCTAssertTrue(mockDataController.loadCommitsCalled)
    }
}

class MockCommitsDataController: CommitsDataControllable {
    var loadCommitsCalled = false
    var repoName = ""
    func loadCommits(from repo: String) -> Observable<[Commit]> {
        loadCommitsCalled = true
        repoName = repo
        return Observable.never()
    }
}
