//
//  Photo.swift
//  Project13
//
//  Created by Shawn Bierman on 3/31/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

class Photo: Codable {
    var name: String
    var caption: String
    
    init(name: String, caption: String) {
        self.name = name
        self.caption = caption
    }
}
