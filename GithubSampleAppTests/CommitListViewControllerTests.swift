//
//  CommitListViewControllerTests.swift
//  GithubSampleAppTests
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import GithubSampleApp

class CommitListViewControllerTests: XCTestCase {
    var testScheduler: TestScheduler!
    var mockViewModel: MockCommitListViewModel!
    var subject: CommitListViewController!
    
    override func setUp() {
        testScheduler = TestScheduler(initialClock: 0)
        mockViewModel = MockCommitListViewModel()
        subject = CommitListViewController(viewModel: mockViewModel,
                                           scheduler: testScheduler)
    }
    
    func testWhenViewIsLoadedShouldLoadCommits() {
        _ = subject.view
        XCTAssertTrue(mockViewModel.loadCommitsCalled)
    }
    
    func testWhenLoadedCommitsSuccesfullyShouldReloadCollectionView() {
        _ = subject.view
        mockViewModel.commitsPublishSubject.onNext(Commit.fakeCommits)
        testScheduler.start()
        XCTAssertEqual(2, subject.collectionView.numberOfItems(inSection: 0))
    }
}

extension Commit {
    static var fakeCommits = [Commit(sha: "123", authorName: "Gokul", description: "Tests"),
                              Commit(sha: "1234", authorName: "Sai", description: "Code")]
}

class MockCommitListViewModel: CommitListViewable {
    var loadCommitsCalled = false
    var commitsPublishSubject = PublishSubject<[Commit]>()
    func loadCommits(repoName: String) -> Observable<[Commit]> {
        loadCommitsCalled = true
        return commitsPublishSubject.asObservable()
    }
}
