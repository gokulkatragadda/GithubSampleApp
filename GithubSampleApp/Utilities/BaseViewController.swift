//
//  BaseViewController.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    var rootView: T!
    
    override func loadView() {
        super.loadView()
        rootView = T()
        view = rootView
    }
}
