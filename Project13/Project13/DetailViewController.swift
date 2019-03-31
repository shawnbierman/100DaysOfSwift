//
//  DetailViewController.swift
//  Project13
//
//  Created by Shawn Bierman on 3/31/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    
    var selectedImage: String?
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let imageName = selectedImage,
            let path = paths?.appendingPathComponent(imageName) {
            imageView.image = UIImage(contentsOfFile: path.path)
        }
        
        captionLabel.text = caption
    }
}
