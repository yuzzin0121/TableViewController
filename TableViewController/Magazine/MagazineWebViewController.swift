//
//  MagazineWebViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import UIKit
import WebKit

class MagazineWebViewController: UIViewController {
    var urlString: String = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showWebView(urlString: urlString)
    }
    
    func showWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
