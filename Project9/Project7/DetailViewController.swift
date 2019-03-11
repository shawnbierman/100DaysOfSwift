//
//  DetailViewController.swift
//  Project7
//
//  Created by Shawn Bierman on 3/6/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        let title = detailItem.title
        let signatureCount = detailItem.signatureCount
        let signatureThreshold = detailItem.signatureThreshold
        let signaturesFormatted = "\(signatureCount)/\(signatureThreshold)"
        let status = detailItem.status
        
        var newBody = detailItem.body.replacingOccurrences(of: "\n", with: "<br />")
        newBody = newBody.replacingOccurrences(of: "&amp;#039;", with: "'")
        
        var issues = ""
        detailItem.issues.forEach { item in
            issues += "\(item.name)<br />"
        }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale1">
        <style>
        body { padding: 24px; }
        #container {
            font: -apple-system-tall-body;
            text-align: justify;
        }
        #footer {
            font: -apple-system-footer;
            color: gray;
            font-size: 14px;
        }
        h4 {
            font: -apple-system-headline;
            font-size: 30px;
            text-transform: uppercase;
        }
        h6 {
            font: -apple-system-caption1;
            text-align: right;
            text-transform: uppercase;
            line-height: 0.8em;
        }
        </style>
        </head><body>
        
        
        <h6>Status: <span style="color: blue;">\(status)</span></h6>
        <h6 style="color: gray; line-height: 0.2;">\(signaturesFormatted)</h6>
        
        
        <h4>\(title)</h4>
        <h6 style="background-color: #205493;">&nbsp;</h6>
        
        
        <br />
        <div id="container">
            \(newBody)
        <br /><br />
        
        
        <hr />
        <div id="footer">
        \(issues)
        </div>
        
        
        </div></body></html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
