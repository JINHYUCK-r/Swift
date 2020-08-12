//
//  CustomTableViewCell.swift
//  SimpleTable
//
//  Created by 류진혁 on 2020/08/12.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var leftLabel : UILabel!
    @IBOutlet var rightLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
