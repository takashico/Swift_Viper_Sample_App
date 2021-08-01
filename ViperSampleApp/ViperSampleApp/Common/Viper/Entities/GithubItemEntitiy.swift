//
//  GithubItemEntitiy.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import Foundation

struct GithubItemEntitiy: Codable {
    let id: Int
    let fullName: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case url = "html_url"
    }
}
