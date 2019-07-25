//
//  FriendsViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    var tokens = [NotificationToken?]()
    var items = [Results<Object>]()
    var users: Results<Object>!
    var titlesForSections = [String]()
    var filtered: Results<Object>!
    
    var searchActive = false

    func prepareData() {
        self.users = Session.instance.getObjects(type: User.self).filter("firstName != 'DELETED'").sorted(byKeyPath: "lastName")
        var alphabetIndex = 0
        var token: NotificationToken?
        for section in 0...1000 {
            if alphabetIndex >= (self.users.count) { break }
            let char = String((self.users[alphabetIndex] as! User).lastName.first!)
            self.titlesForSections.append(char)
            self.items.append((self.users.filter("lastName BEGINSWITH %@", char)))
            alphabetIndex += (self.items.last?.count)!
            token = self.items.last?.observe({ (changes) in
                guard let tableView = self.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: section) }),
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: section)}),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: section) }),
                                         with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            })
            self.tokens.append(token)
        }
    }
    
    deinit {
        for token in tokens {
            token?.invalidate()
        }
    }
    
    func createRefreshControl() {
        refreshControl = UIRefreshControl() //CustomRefreshControl(frame: UIRefreshControl().frame)
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRefreshControl()
        DispatchQueue.global().async {
            Session.instance.getFriends { [weak self] in
                self?.prepareData()
            }
        }
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        Session.instance.getFriends { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - SearchBar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = self.users.filter("lastName CONTAINS '\(searchText)' OR firstName CONTAINS '\(searchText)'")
        
        searchActive = searchText.count == 0 ? false : true
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchActive ? nil : titlesForSections
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchActive ? 1 : titlesForSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filtered.count : items[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchActive ? nil : String(titlesForSections[section])
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.textColor = UIColor.gray
        headerView.backgroundView?.backgroundColor = tableView.backgroundColor?.withAlphaComponent(0.5)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId, for: indexPath) as? UserCell else { return UITableViewCell() }
        
        let section = indexPath.section
        let row = indexPath.row
        let friend = searchActive ? filtered[row] as! User : items[section][row] as! User
        cell.name.text = "\(friend.firstName) \(friend.lastName)"
        cell.photo!.sd_setImage(with: URL(string: friend.photo), placeholderImage: UIImage(named: "vk"))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 100, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
            cell.transform = CGAffineTransform(translationX: -100, y: 0)
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let photoViewController = segue.destination as! PhotoViewController
        let cell = sender as! UserCell
        let indexPath = tableView.indexPath(for: cell)
        let section = indexPath!.section
        let row = indexPath!.row
        let friend = searchActive ? filtered[row] as! User : items[section][row] as! User
        let userId = friend.id
        photoViewController.ownerId = userId
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

