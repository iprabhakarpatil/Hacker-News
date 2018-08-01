//
//  MovieListTableViewCell.swift
//  Hacker News
//
//  Created by prabhakar patil on 01/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleasedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
