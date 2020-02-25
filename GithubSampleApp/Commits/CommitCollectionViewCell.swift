//
//  CommitCollectionViewCell.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import UIKit
import SnapKit

class CommitCollectionViewCell: UICollectionViewCell {
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var SHALabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .purple
        label.font = label.font.withSize(14)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .darkGray
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 7
        view.layer.zPosition = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(SHALabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(SHALabel.snp.top)
        }
        
        SHALabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
    }
}
