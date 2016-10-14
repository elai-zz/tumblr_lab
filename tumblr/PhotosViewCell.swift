//
//  PhotosViewCell.swift
//  tumblr
//
//  Created by Minnie Lai on 10/13/16.
//  Copyright © 2016 minnie. All rights reserved.
//

import UIKit

class PhotosViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
