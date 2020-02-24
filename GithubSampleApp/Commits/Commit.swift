//
//  Commit.swift
//  GithubSampleApp
//
//  Created by Gokul Sai Katragadda on 2/24/20.
//  Copyright © 2020 AppFactory. All rights reserved.
//

import Foundation

struct Commit: Decodable {
    let sha: String
    let authorName: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case sha
        case authorName = "name"
        case description = "message"
        case commit = "commit"
        case author = "author"
    }
    
    init(sha: String, authorName: String, description: String) {
        self.sha = sha
        self.authorName = authorName
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sha = try container.decode(String.self, forKey: .sha)
        let commit = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .commit)
        description = try commit.decode(String.self, forKey: .description)
        let author = try commit.nestedContainer(keyedBy: CodingKeys.self, forKey: .author)
        authorName = try author.decode(String.self, forKey: .authorName)
    }
}
