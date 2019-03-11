//
//  Petition.swift
//  Project7
//
//  Created by Shawn Bierman on 3/5/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
    var signatureThreshold: Int
    var status: String
    var issues: [Issues]
}
