//
//  CollectionViewCell.swift
//  Milestone10
//
//  Created by Shawn Bierman on 6/2/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let backImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .clear

        [backImageView, frontImageView].forEach { addSubview( $0 ) }

        backImageView.fillSuperview()
        frontImageView.fillSuperview()

        frontImageView.isHidden = true
        backImageView.isHidden = false

    }
}
