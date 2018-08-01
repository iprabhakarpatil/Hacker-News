//
//  MostViewedTableViewCell.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class MostViewedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
