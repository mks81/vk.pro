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
    
    var friends: [User] = []
    
    var titleForSection = [String]()
    var items = [[User]]()
    
    var searchActive = false
    var filtered = [User]()

    func getData() {
        DispatchQueue.global().async {
            Session.instance.getFriends { [weak self] in
                self?.friends = Session.instance.getObjects(type: User.self).filter("firstName != 'DELETED'").sorted(byKeyPath: "lastName").toArray(ofType: User.self) as [User]
                self?.prepareData()
            }
        }
    }
    
    func prepareData() {
        items = [[User]]()
        titleForSection = [String]()
        var section = 0
        titleForSection.append(String(friends[0].lastName.first ?? friends[0].firstName.first!))
        items.append([User]())
        items[section].append(friends[0])
        
        for row in 1..<friends.count {
            let leftValue = friends[row - 1].lastName.first ?? friends[row - 1].firstName.first
            let rightValue = friends[row].lastName.first ?? friends[row].firstName.first
            if leftValue == rightValue {
                items[section].append(friends[row])
            } else {
                titleForSection.append(String(rightValue!))
                section += 1
                items.append([User]())
                items[section].append(friends[row])
            }
        }
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func createRefreshControl() {
        refreshControl = UIRefreshControl() //CustomRefreshControl(frame: UIRefreshControl().frame)
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRefreshControl()
        getData()
    }

    @objc func refresh(refreshControl: UIRefreshControl) {
        getData()
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
        filtered = friends.filter { $0.firstName.lowercased().contains(searchText.lowercased()) || $0.lastName.lowercased().contains(searchText.lowercased())}
        
        searchActive = searchText.count == 0 ? false : true
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchActive ? nil : titleForSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchActive ? 1 : titleForSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filtered.count : items[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchActive ? nil : String(titleForSection[section])
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
        let friend = searchActive ? filtered[row] : items[section][row]
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
        let friend = searchActive ? filtered[row] : items[section][row]
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
