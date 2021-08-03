//
//  GithubItemsParameter.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/03.
//

final class GithubItemsParameter {
    let language: String
    let page: Int
    let per_page: Int
    
    init(language: String, page: Int, per_page: Int) {
        self.language = language
        self.page = page
        self.per_page = per_page
    }
    
    func toDictionary() -> [String: String] {
        return [
            "q" : language,
            "page" : String(page),
            "per_page" : String(per_page),
        ]
    }
}
