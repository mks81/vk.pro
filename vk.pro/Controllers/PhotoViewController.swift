//
//  PhotoViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 23/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "PhotoCell"

class PhotoViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var ownerId = 0
    var photos: [Photo] = []
    
    let cellsCount = 2
    let spacing: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Session.instance.getPhotos(ownerId: ownerId) {[weak self] (photos) in
            self!.photos = photos
            self!.collectionView.reloadData()
        }
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
    
        let photo = photos[indexPath.item]
        cell.photo.sd_setImage(with: URL(string: (photo.sizes[2].url)), placeholderImage: UIImage(named: "vk"))
        cell.likesControl.likesCount = photo.likes["count"] ?? 0
        cell.likesControl.alreadyLiked = photo.likes["user_likes"] ?? 0 == 1
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacingCount = cellsCount - 1
        let viewWidth = collectionView.frame.width
        let size = ((viewWidth - CGFloat(spacingCount) * spacing)) / CGFloat(cellsCount)
      
        return CGSize(width: size, height: size)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let photoController = segue.destination as! PhotoController
        //photoController.photos = photos
    }
}
