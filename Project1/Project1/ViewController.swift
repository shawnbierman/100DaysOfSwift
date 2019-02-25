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
