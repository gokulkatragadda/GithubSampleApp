//
//  CommitListViewModel.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import Foundation
import RxSwift


protocol CommitListViewable {
    func loadCommits(repoName: String) -> Observable<[Commit]>
}

class CommitListViewModel: CommitListViewable {
    
    let dataController: CommitsDataControllable
    
    init(dataController: CommitsDataControllable) {
        self.dataController = dataController
    }
    
    convenience init() {
        self.init(dataController: CommitsDataController())
    }
    
    func loadCommits(repoName: String) -> Observable<[Commit]> {
        return dataController.loadCommits(from: repoName)
    }
}


