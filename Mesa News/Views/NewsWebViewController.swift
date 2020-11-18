//
//  NewsWebViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var urlStr: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlStr = urlStr else {
            return
        }
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
        self.view.addSubview(webView)
        self.view.sendSubviewToBack(webView)
    }

}
