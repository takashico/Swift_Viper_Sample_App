//
//  GithubItemDetailPresenter.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/02.
//

import Foundation
import WebKit

protocol GithubItemDetailPresenterProtocol: AnyObject {
    
    func didLoad()
}

/// Viewが準拠するプロトコル
protocol GithubItemDetailViewProtocol: AnyObject {
    
    func requestWebView(with request: URLRequest)
}

class GithubItemDetailPresenter {
    
    weak var view: GithubItemDetailViewProtocol!
    private var githubItemEntity: GithubItemEntitiy
    
    init(view: GithubItemDetailViewProtocol, entity: GithubItemEntitiy) {
        self.view = view
        self.githubItemEntity = entity
    }
}

extension GithubItemDetailPresenter: GithubItemDetailPresenterProtocol {
    func didLoad() {
        guard let url = URL(string: githubItemEntity.url) else { return }
        
        view.requestWebView(with: URLRequest(url: url))
    }
}
