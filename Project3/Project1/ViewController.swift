//
//  ViewController.swift
//  Project1
//
//  Created by Shawn Bierman on 2/16/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleAction))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }

        pictures.sort()
    }
    
    @objc func handleAction() {
        
        let activityItems = "You should try this App!"
        
        let vc = UIActivityViewController(activityItems: [activityItems], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {

            vc.selectedImage = pictures[indexPath.row]                      // filename as String?

            if let selectedImage = vc.selectedImage,                        // unwrapped filename
                let imageIndex = pictures.firstIndex(of: selectedImage) {   // unwrapped index
                vc.title = "Picture \(imageIndex + 1) of \(pictures.count)" // set formatted title
            } else {
                vc.title = vc.selectedImage                                 // fallback to <filename>
            }

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// 1. Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
// 2. Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
// 3. Go back to project 2 and add a bar button item that shows their score when tapped.
