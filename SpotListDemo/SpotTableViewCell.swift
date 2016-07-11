//
//  SpotTableViewCell.swift
//  SpotListDemo
//
//  Created by Julian Hulme on 2016/06/08.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
