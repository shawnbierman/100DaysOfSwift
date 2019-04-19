//
//  Country.swift
//  Milestone5
//
//  Created by Shawn Bierman on 4/14/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import Foundation

struct Country: Codable {
    let currencies: [Currency]
    let flag: String
    let name, capital: String
    let region: Region
    let population: Int
    let area: Double?
}

struct Currency: Codable {
    let code, name, symbol: String?
}

enum Region: String, Codable, CaseIterable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case unknown = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}
