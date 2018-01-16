//
//  MemoriesTableViewCell.swift
//  00357034_final
//
//  Created by user_17 on 2017/6/19.
//  Copyright © 2017年 user_17. All rights reserved.
//

import UIKit

class MemoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
