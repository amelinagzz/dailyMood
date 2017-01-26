//
//  MoodCellTableViewCell.swift
//  dailymood
//
//  Created by Adriana Gonzalez on 1/25/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import UIKit

class MoodCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
