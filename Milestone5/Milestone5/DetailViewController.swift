//
//  DetailViewController.swift
//  Milestone5
//
//  Created by Shawn Bierman on 4/14/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    let webView = WKWebView()
    var country: Country?
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = country else { return }
        title = country.name
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showFact))
        
        loadHtml(country: country)
    }
    
    @objc fileprivate func showFact(_ sender: UIBarButtonItem) {
        print("fact")
    }
    
    fileprivate func loadHtml(country: Country) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let name = country.name
        let capital = country.capital
        let population = String(describing: numberFormatter.string(from: NSNumber(value: country.population))!)
        let area = String(describing: numberFormatter.string(from: NSNumber(value: country.area ?? 0.0))!)
        let flag = country.flag
        let region = country.region.rawValue
        var currencyStr = ""
        country.currencies.forEach { currency in
            let name = currency.name ?? ""
            let symbol = currency.symbol ?? ""
            let code = currency.code ?? ""
            currencyStr = "\(name)<br />\(symbol) (\(code))"
        }
        
        let html = """
        <html><head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        
        body { font: -apple-system-tall-body; font-size: 20px; background-color: #fffffe; padding: 4px; }
        h1 { text-align: center; font-size: 35px; }
        img { text-align: center; }
        #boxshadow {
        position: relative;
        box-shadow: 1px 2px 4px rgba(0, 0, 0, .5);
        padding: 2px;
        background: white;
        }
        
        #boxshadow img {
        width: 100%;
        border: 1px solid #8a4419;
        border-style: inset;
        }
        
        #boxshadow::after {
        content: '';
        position: absolute;
        z-index: -1; /* hide shadow behind image */
        box-shadow: 0 15px 20px rgba(0, 0, 0, 0.3);
        width: 70%;
        left: 15%; /* one half of the remaining 30% */
        height: 100px;
        bottom: 0;
        }
        .leftColumn {width: 40%; text-align: right; font-weight: bold; vertical-align: top; }
        .rightColumn {width: 60%; text-align: left; padding-left: 20px; }
        .row { }
        
        </style>
        </head>
        <body>
        
        <br />
        <h1>\(name)</h1>
        
        <h1><img id="boxshadow" src="\(flag)" width="200" /></h1>
        <br />
        <hr style="width: 80%;" />
        
        <table style="height: 147px; margin-left: auto; margin-right: auto; width: 100%;">
        <tbody>
        <tr class="row">
        <td class="leftColumn">Country</td>
        <td class="rightColumn">\(name)</td>
        </tr>
        <tr class="row">
        <td class="leftColumn">Capital</td>
        <td class="rightColumn">\(capital)</td>
        </tr>
        <tr class="row">
        <td class="leftColumn">Region</td>
        <td class="rightColumn">\(region)</td>
        </tr>
        <tr class="row">
        <td class="leftColumn">Population</td>
        <td class="rightColumn">\(population)</td>
        </tr>
        <tr class="row">
        <td class="leftColumn">Area</td>
        <td class="rightColumn">\(area)</td>
        </tr>
        <tr class="row">
        <td class="leftColumn">Currency</td>
        <td class="rightColumn">\(currencyStr)</td>
        </tr>
        </tbody>
        </table>
        
        </body>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    deinit {
        if webView.isLoading {
            webView.stopLoading()
        }
    }
}
