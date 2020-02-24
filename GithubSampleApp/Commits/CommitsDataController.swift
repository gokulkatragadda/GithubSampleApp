//
//  CommitsDataController.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import RxSwift
import RxRelay
import Foundation

enum GTError: Error {
    case malformedURL
}

protocol CommitsDataControllable {
    func loadCommits(from repo: String) -> Observable<[Commit]>
}


class CommitsDataController: CommitsDataControllable {
    private let disposeBag = DisposeBag()
    private let scheme = "https"
    private let host = "api.github.com"
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    convenience init() {
        self.init(networkClient: NetworkClientImpl())
    }
    
    func loadCommits(from repo: String) -> Observable<[Commit]> {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/repos/\(repo)/commits"
        guard let url = urlComponents.url else { return .error(GTError.malformedURL)}
        
        let request = URLRequest(url: url)
        return networkClient.executeDataRequest(request: request)
    }
}
