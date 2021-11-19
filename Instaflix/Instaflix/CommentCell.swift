//
//  CommentCell.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/19/21.
//

import UIKit
import AlamofireImage
import Parse

class CommentCell: UITableViewCell {

    
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    

    @IBOutlet weak var userText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
