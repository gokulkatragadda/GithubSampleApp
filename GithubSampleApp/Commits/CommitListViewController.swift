//
//  CommitListViewController.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CommitListViewController: BaseViewController<CommitListView> {
    private let disposeBag = DisposeBag()
    private let viewModel: CommitListViewable
    private let scheduler: SchedulerType
    
    private var commits = [Commit]()
    private let repoName = "apple/swift"
    
    init(viewModel: CommitListViewable,
         scheduler: SchedulerType) {
        self.viewModel = viewModel
        self.scheduler = scheduler
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        self.init(viewModel: CommitListViewModel(),
                  scheduler: MainScheduler.instance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView = rootView.collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CommitCollectionViewCell.self, forCellWithReuseIdentifier: "CommitCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = repoName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bindViewModel() {
        viewModel.loadCommits(repoName: repoName)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (commits) in
                self?.commits = commits
                self?.rootView.collectionView.reloadData()
            }, onError: { (error) in
                print("error: \(error)")
            })
        .disposed(by: disposeBag)
    }
}

extension CommitListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitCollectionViewCell", for: indexPath) as! CommitCollectionViewCell
        cell.SHALabel.text = commits[indexPath.row].sha
        cell.authorLabel.text = commits[indexPath.row].authorName
        cell.descriptionLabel.text = commits[indexPath.row].description
        return cell
    }
}

extension CommitListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
