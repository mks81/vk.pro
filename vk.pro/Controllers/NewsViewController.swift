//
//  NewsViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 06/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewsCell"

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var photo = "putin"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        
        cell.avatar.image = UIImage(named: "musk")
        cell.photo.image = UIImage(named: photo)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.width
        let photoWidth = UIImage(named: photo)!.size.width
        let photoHeight = UIImage(named: photo)!.size.height
        let ratio = frameWidth / photoWidth
        
        return CGSize(width: frameWidth, height: photoHeight * ratio + 155)
    }

}
