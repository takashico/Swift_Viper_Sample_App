//
//  GIthubItemListRouterProtocol.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import UIKit

protocol GithubItemListRouterProtocol: AnyObject {
    
    func showGithubItemDetail(githubItemEntity: GithubItemEntitiy)
}

class GithubItemListRouter: GithubItemListRouterProtocol {
    
    weak var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func showGithubItemDetail(githubItemEntity: GithubItemEntitiy) {
        let viewController = GithubItemDetailViewController.instantiate()
        
        viewController.presenter = GithubItemDetailPresenter(
            view: viewController,
            entity: githubItemEntity
        )
        
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
