//
//  NewsViewController.swift
//  vk.pro
//
//  Created by mks on 11/08/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import RealmSwift

class NewsViewController: UITableViewController {
    
    private var token = NotificationToken()
    private var news: Results<Object>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            Session.instance.getNews { [weak self] in
                self?.setup()
            }
        }
    }
    
    func setup() {
        news = Session.instance.getObjects(type: News.self)
        //print(news)
        token = news.observe({ (changes) in
            guard let tableView = self.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    deinit {
        token.invalidate()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        //        let section = indexPath.section
        let row = indexPath.row
        let news = self.news[row] as! News
        if news.sourceId < 0 {
            let group = Session.instance.getObjects(type: NewsGroup.self).filter("id == \(-news.sourceId)")[0] as! NewsGroup
            cell.avatar!.sd_setImage(with: URL(string: group.photo), placeholderImage: UIImage(named: "vk"))
            cell.name.text = group.name
        } else {
            let user = Session.instance.getObjects(type: NewsProfile.self).filter("id == \(news.sourceId)")[0] as! NewsProfile
            cell.avatar!.sd_setImage(with: URL(string: user.photo), placeholderImage: UIImage(named: "vk"))
            cell.name.text = "\(user.firstName) \(user.lastName)"
        }
        //        cell.name.text = "\(friend.firstName) \(friend.lastName)"
        //        cell.photo!.sd_setImage(with: URL(string: friend.photo), placeholderImage: UIImage(named: "vk"))
        //cell.name.text = news.type

        return cell
    }
    
}

