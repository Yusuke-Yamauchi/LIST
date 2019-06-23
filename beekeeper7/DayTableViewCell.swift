//
//  DayTableViewCell.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/22.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var photoImage: UIImageView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var honbunLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
