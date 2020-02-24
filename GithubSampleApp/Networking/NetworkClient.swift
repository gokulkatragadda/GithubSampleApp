//
//  NetworkClient.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import RxSwift
import Foundation

enum NetworkClientError: Error {
    case decodingError
}

protocol NetworkClient {
    func executeDataRequest<T: Decodable>(request: URLRequest) -> Observable<T>
}

class NetworkClientImpl: NetworkClient {
    let urlSession: URLSessionType
    
    init(urlSession: URLSessionType) {
        self.urlSession = urlSession
    }
    
    convenience init() {
        self.init(urlSession: URLSession.shared)
    }
    
    func executeDataRequest<T>(request: URLRequest) -> Observable<T> where T : Decodable {
        let subject = PublishSubject<T>()
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                subject.onError(error)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(T.self, from: data)
                    subject.onNext(model)
                } catch {
                    print("Decoding failed...")
                    subject.onError(NetworkClientError.decodingError)
                }
            }
        }.resume()
        return subject.asObservable()
    }
}
