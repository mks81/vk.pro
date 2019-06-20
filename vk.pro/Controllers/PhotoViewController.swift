//
//  PhotoViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 23/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    let cellsCount = 2
    let spacing: CGFloat = 2
    
    var photo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
    
        cell.photo.image = UIImage(named: photo)
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let frameWidth = collectionView.frame.width
//        let photoWidth = UIImage(named: photo)!.size.width
//        let photoHeight = UIImage(named:photo)!.size.height
//        let ratio = frameWidth / photoWidth
//
//        return CGSize(width: frameWidth, height: photoHeight * ratio)
       // collectionViewLayout.

        
        let spacingCount = cellsCount + 1
        let viewWidth = collectionView.frame.width
        let size = ((viewWidth - CGFloat(spacingCount) * spacing)) / CGFloat(cellsCount)
      
        return CGSize(width: size, height: size)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let photoController = segue.destination as! PhotoController
        photoController.photo = photo
    }
}
