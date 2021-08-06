//
//  SceneDelegate.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/07/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let viewController = GithubItemListViewController.instantiate()
        
        viewController.presenter = GithubItemListPresenter(
            view: viewController,
            inject: GithubItemListPresenter.Dependency(
                router: GithubItemListRouter(view: viewController),
                getGithubItemsUseCase: UseCase(GetGithubItemsUseCase())
            )
        )
        
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

