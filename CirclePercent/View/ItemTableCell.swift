//
//  ItemTableCell.swift
//  CirclePercent
//
//  Created by Takaki Otsu on 2019/06/23.
//  Copyright © 2019 Takaki Otsu. All rights reserved.
//

import UIKit

class ItemTableCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
