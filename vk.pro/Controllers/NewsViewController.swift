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
    
    var news: [NewsModel] = [
        NewsModel(name: "Elon Musk", avatar: "musk", text: "SpaceX Илона Маска запустил на орбиту сразу 60 спутников. И это только начало", photo: "spacex"),
        NewsModel(name: "Владимир Путин", avatar: "putin", text: "Владимир Путин подписал Указ «О формировании Администрации Президента Российской Федерации»", photo: "kreml1")
    ]
    
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
        
        let row = indexPath.row
        cell.name.text = news[row].name
        cell.avatar.image = UIImage(named: news[row].avatar)
        cell.text.text = news[row].text
        cell.photo.image = UIImage(named: news[row].photo)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return news.count
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        let frameWidth = collectionView.frame.width
        let photoWidth = UIImage(named: news[row].photo)!.size.width
        let photoHeight = UIImage(named: news[row].photo)!.size.height
        let ratio = frameWidth / photoWidth
        
        return CGSize(width: frameWidth, height: photoHeight * ratio + 155)
    }

}
