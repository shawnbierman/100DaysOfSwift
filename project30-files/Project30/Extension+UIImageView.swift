//
//  Extension+UIImageView.swift
//  Project30
//
//  Created by Shawn Bierman on 5/31/19.
//  Copyright © 2019 Hudzilla. All rights reserved.
//

import UIKit

extension UIImageView {

    // this declutters the cellForRowAt() method a bit
//    func shadowPath(with rect: CGRect) {
    func shadowPath() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize.zero
    }
}
