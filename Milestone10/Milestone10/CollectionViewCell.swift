//
//  CollectionViewCell.swift
//  Milestone10
//
//  Created by Shawn Bierman on 6/2/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    let container: UIView = {
        let view = UIView()
        return view
    }()

    let frontImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let backImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Earth")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        [container].forEach { addSubview( $0 ) }
        [backImageView, frontImageView].forEach { container.addSubview( $0 ) }

        container.fillSuperview()
        backImageView.fillSuperview()
        frontImageView.fillSuperview()

        frontImageView.isHidden = true
        backImageView.isHidden = false

        self.shadow()
    }

    func shadow() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
