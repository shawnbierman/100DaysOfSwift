//
//  BaseTableViewController.swift
//  Milestone8
//
//  Created by Shawn Bierman on 5/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavivationItems()
    }

    fileprivate func setupTableView() {
        let tableViewBackground = UIImageView(image: UIImage(named: "wallpaper"))
        tableView.backgroundView = tableViewBackground
    }

    fileprivate func setupNavivationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .gold
    }
}
