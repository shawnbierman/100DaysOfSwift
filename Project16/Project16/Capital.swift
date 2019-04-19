//
//  Capital.swift
//  Project16
//
//  Created by Shawn Bierman on 4/19/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var url: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, url: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.url = url
    }

}
