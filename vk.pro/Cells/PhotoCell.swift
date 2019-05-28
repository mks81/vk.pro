//
//  PhotoViewCell.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 23/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, PhotoCellCommunicationDelegate {
    
    var like = Int.random(in: 0...100)
    var alreadyLiked = Bool.random()
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likesControl: LikesControl!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    
    func trackingEnded() {
        if alreadyLiked {
            likeImageView.image = UIImage(named: "like")
            like -= 1
            likeLabel.text = String(like)
        } else {
            likeImageView.image = UIImage(named: "like-filled")
            like += 1
            likeLabel.text = String(like)
        }
        alreadyLiked = !alreadyLiked
    }
    
}
