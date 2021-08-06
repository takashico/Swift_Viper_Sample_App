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
    @IBOutlet var indicatorFooterView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var githubItemEntities = [GithubItemEntitiy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorFooterView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)
        self.tableView.tableFooterView = indicatorFooterView
        indicatorView.startAnimating()
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !self.githubItemEntities.isEmpty else { return }
        
        if indexPath.row >= (githubItemEntities.count - 2) {
            presenter.loadGithubItemsMore()
        }
    }
}

extension GithubItemListViewController: GithubItemListViewProtocol {
    
    func showGithubItems(_ items: [GithubItemEntitiy]) {
        self.githubItemEntities.append(contentsOf: items)
        self.tableView.reloadData()
    }
    
    func showEmpty() {
        showGithubItems([])
    }
    
    func showError(_ error: Error) {
        // エラー画面を表示する
    }
    
    func indicatorView(animate: Bool) {
        // TODO: フェッチするデータがなくなったときにはUIView()をフッターに設定する
        // 条件としては、取得したデータが20件未満だった場合に取得するデータがなくなったと判断できる
        if animate {
            indicatorView.startAnimating()
        } else {
            self.tableView.tableFooterView = UIView()
        }
    }
}
