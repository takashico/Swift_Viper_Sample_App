//
//  GithubItemListPresenterProtocol.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import Foundation

protocol GithubItemListPresenterProtocol: AnyObject {
    
    func didLoad()
    func loadGithubItemsMore()
    func didSelect(githubItemEntity: GithubItemEntitiy)
}

/// Viewが準拠するプロトコル
protocol GithubItemListViewProtocol: AnyObject {
    
    func showGithubItems(_ items: [GithubItemEntitiy])
    func showEmpty()
    func showError(_ error: Error)
}

class GithubItemListPresenter {
    
    struct Dependency {
        let router: GithubItemListRouter!
        let getGithubItemsUseCase: UseCase<GithubItemsParameter, [GithubItemEntitiy], Error>
    }
    
    private var page: Int = 1
    private let perPage: Int = 20
    
    weak var view: GithubItemListViewProtocol!
    private var di: Dependency
    
    init(view: GithubItemListViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
}

extension GithubItemListPresenter: GithubItemListPresenterProtocol {
    func didLoad() {
        di.getGithubItemsUseCase.execute(GithubItemsParameter(language: "swift", page: page, per_page: perPage)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let githubItemEntities):
                if githubItemEntities.isEmpty {
                    self.view.showEmpty()
                } else {
                    self.view.showGithubItems(githubItemEntities)
                }
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
    
    func loadGithubItemsMore() {
        page = page + 1
        di.getGithubItemsUseCase.execute(GithubItemsParameter(language: "swift", page: page, per_page: perPage)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let githubItemEntities):
                if githubItemEntities.isEmpty {
                    // TODO: ローディングをやめる
                } else {
                    self.view.showGithubItems(githubItemEntities)
                }
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
    
    func didSelect(githubItemEntity: GithubItemEntitiy) {
        di.router.showGithubItemDetail(githubItemEntity: githubItemEntity)
    }
}
