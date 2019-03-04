//
//  TableViewController.swift
//  milestone2
//
//  Created by Shawn Bierman on 3/4/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleClearList))
        let trashButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleAddItem))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShare))
        navigationItem.rightBarButtonItems = [trashButton, shareButton]

    }

    @objc func handleAddItem() {
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField { tf in
            tf.autocapitalizationType = UITextAutocapitalizationType.words
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let newItem = ac?.textFields?[0].text else { return }
            if newItem.isEmpty { return }
            self?.shoppingList.insert(newItem, at: 0)
            self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    @objc func handleClearList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func handleShare() {
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
        present(vc, animated: true, completion: nil)
    }
}

extension TableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        print(shoppingList)
        return cell
    }
}
