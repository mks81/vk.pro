//
//  FriendTableViewCell.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let reuseId = "UserCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    //@IBOutlet weak var avatarView: AvatarView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
