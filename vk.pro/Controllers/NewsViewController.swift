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
    private var news: [News] = []
    private var user: Results<Object>!
    private var group: Results<Object>!
    private var cellPresenters: [CellPresenter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            Session.instance.getNews { [weak self] (news) in
                self?.news = news
                self?.setup()
            }
        }
    }
    
    func setup() {
        //news = Session.instance.getObjects(type: News.self)
        for news in news {
            //let news = new as! News
            
            if news.sourceId < 0 {
                Session.instance.getGroupById(id: -news.sourceId) { (group) in
                    news.sourceAvatar = group.photo
                    news.sourceName = "\(group.name)"
                    //self?.cell.sourceAvatar
                    //self.tableView.reloadData()
                }
            } else {
                Session.instance.getUser(id: news.sourceId) { (user) in
                    news.sourceAvatar = user.photo
                    news.sourceName = "\(user.firstName) \(user.lastName)"
                    //self.tableView.reloadData()
                }
            }
        }
        
//        print(cellPresenters.count)
//        token = news.observe({ (changes) in
//            guard let tableView = self.tableView else { return }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
//                                     with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.endUpdates()
//            case .error(let error):
//                fatalError("\(error)")
//            }
//        })
    }
    
    deinit {
        token.invalidate()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
//        let section = indexPath.section
        let row = indexPath.row
        let news = self.news[row]
//        self.cellPresenters[row].cell = cell
//        self.cellPresenters[row].index = row
//        self.cellPresenters[row].news = news
        
//        cell.name.text = "\(friend.firstName) \(friend.lastName)"
//        cell.photo!.sd_setImage(with: URL(string: friend.photo), placeholderImage: UIImage(named: "vk"))
        cell.name.text = news.type
        //print(news.sourceName)
        
        return cell
    }
    
}

class CellPresenter {
    var cell: NewsCell?
    var news: News?
    
    var index = Int.max {
        didSet {
            if self.index == Int.max { return }

        }
    }
}
