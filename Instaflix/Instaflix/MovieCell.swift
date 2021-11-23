//
//  MovieCell.swift
//  Instaflix
//
//  Created by Edgar Bermudez and Ciara Morell on 11/19/21.
//

import UIKit
import AlamofireImage
import Parse

class MovieCell: UITableViewCell {

    
    //@IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var synopsis: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
