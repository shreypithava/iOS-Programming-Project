//
//  MessageTableViewCell.swift
//  Project
//
//  Created by Shrey Pithava on 4/5/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageArea: UIView!
    @IBOutlet weak var sendersName: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var sendersImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
