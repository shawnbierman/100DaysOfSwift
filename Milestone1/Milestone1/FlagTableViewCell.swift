//
//  FlagTableViewCell.swift
//  Milestone1
//
//  Created by Shawn Bierman on 2/24/19.
//  Copyright © 2019 Shawn Bierman. All rights reserved.
//

import UIKit

class FlagTableViewCell: UITableViewCell {

    let image: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
