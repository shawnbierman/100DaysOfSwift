//
//  DetailViewController.swift
//  Project4
//
//  Created by Shawn Bierman on 2/24/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "google.com"]
    var selectedWebsite: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(goForward))
        
        toolbarItems = [backButton, progressButton, spacer, refresh, forwardButton]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)


        guard let site = selectedWebsite else { return }
        if websites.contains(site),
            let url = URL(string: "https://" + site) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        } else {
            badsiteAlert()
        }
    }
    
    @objc func goBack() { if webView.canGoBack { webView.goBack() }}
    @objc func goForward() { if webView.canGoForward { webView.goForward() }}
    
    enum direction { case forward, back }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        badsiteAlert()
        
        decisionHandler(.cancel)
    }
    
    func badsiteAlert() {
        let message = "Website has not been whitelisted."
        let ac = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

// One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:
//
// 1. If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.

// 2. Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward.

// 3. For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.

// Tip: Once you have completed project 5, you might like to return here to add in the option to load the list of websites from a file, rather than having them hard-coded in an array.
