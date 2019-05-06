//
//  Folder.swift
//  Milestone8
//
//  Created by Shawn Bierman on 5/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

struct Folder: Codable {
    let id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
