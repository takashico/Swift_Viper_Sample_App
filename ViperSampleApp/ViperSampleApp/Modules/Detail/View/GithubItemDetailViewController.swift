//
//  GithubItemDetailWebViewController.swift
//  ViperSampleApp
//
//  Created by Takahashi Shiko on 2021/08/01.
//

import UIKit
import WebKit

class GithubItemDetailViewController: UIViewController {
    
    var presenter: GithubItemDetailPresenterProtocol!
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.didLoad()
    }
}

extension GithubItemDetailViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        presenter?.webView(webView, didFinish: navigation)
//    }
}

extension GithubItemDetailViewController: GithubItemDetailViewProtocol {
    func requestWebView(with request: URLRequest) {
        self.webView.load(request)
    }
}
