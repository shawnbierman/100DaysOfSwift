//
//  Note.swift
//  Milestone8
//
//  Created by Shawn Bierman on 5/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

class Note: Codable {
    let id: String
    let title: String
    let body: String
    let folder: Folder

    init(id: String, title: String, body: String, folder: Folder) {
        self.id = id
        self.title = title
        self.body = body
        self.folder = folder
    }
}
