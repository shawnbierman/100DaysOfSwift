//
//  Person.swift
//  Project10
//
//  Created by Shawn Bierman on 3/17/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
