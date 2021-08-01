//
//  ViewController.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/07/31.
//

import UIKit

class GithubItemListViewController: UIViewController {
    
    var presenter: GithubItemListPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    private var githubItemEntities = [GithubItemEntitiy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.didLoad()
    }
}

extension GithubItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubItemEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = githubItemEntities[indexPath.row]
        cell.textLabel?.text = item.fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelect(githubItemEntity: githubItemEntities[indexPath.row])
    }
}

extension GithubItemListViewController: GithubItemListViewProtocol {
    
    func showGithubItems(_ githubItemEntities: [GithubItemEntitiy]) {
        self.githubItemEntities = githubItemEntities
        self.tableView.reloadData()
    }
    
    func showEmpty() {
        showGithubItems([])
    }
    
    func showError(_ error: Error) {
        // エラー画面を表示する
    }
}
