//
//  ViewController.swift
//  Project18
//
//  Created by Shawn Bierman on 4/21/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        print(1,2,3,4,5, separator: "-")
//        print("Some message", terminator: "")
//        assert(1==2, "No it doesn't")
        for i in 1...100 {
            print("Got number: \(i)")
        }
    }
}
