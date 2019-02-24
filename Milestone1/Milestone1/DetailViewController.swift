//
//  DetailViewController.swift
//  Milestone1
//
//  Created by Shawn Bierman on 2/23/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var imageFilename: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = country
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        image.image = UIImage(named: imageFilename!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        
    }
    
    @objc func shareFlag() {
        
        let message = "Here is the \(title!) flag!"
        guard let image = image.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let activityItems = [message, image] as [Any]
        
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
    }
    
}
