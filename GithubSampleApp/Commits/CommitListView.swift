//
//  CommitListView.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import UIKit
import SnapKit

class CommitListView: UIView {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor(red: 76, green: 226, blue: 232, alpha: 1)
        collectionView.allowsSelection = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
}
