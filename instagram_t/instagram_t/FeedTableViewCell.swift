//
//  FeedTableViewCell.swift
//  instagram_t
//
//  Created by RuiJun haung on 2021/4/4.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

   
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var UserInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
