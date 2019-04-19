//
//  DetailViewController.swift
//  Project16
//
//  Created by Shawn Bierman on 4/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var capital: Capital?
    
    override func loadView() {
        webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = capital?.url else { return }
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
