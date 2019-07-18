//
//  GroupViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import SDWebImage

class GroupViewController: UITableViewController {

    var groups = [[Group]]()
    var filtered = [Group]()
    
    var searchActive = false
    
    func createRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        getData()
    }
    
    func getData() {
        DispatchQueue.global().async {
            Session.instance.getGroups { [weak self] in
                self?.groups[0] = Session.instance.getObjects(type: Group.self).sorted(byKeyPath: "name").toArray(ofType: Group.self) as [Group]
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        createRefreshControl()
        super.viewDidLoad()
        for _ in 0...1 {
            groups.append([Group]())
        }
        getData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchActive && section == 1 ? "Глобальный поиск" : nil
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.textColor = UIColor.gray
        headerView.backgroundView?.backgroundColor = tableView.backgroundColor?.withAlphaComponent(0.5)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchActive ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchActive && section == 0 ? filtered.count : groups[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { return UITableViewCell() }

        let section = indexPath.section
        let row = indexPath.row
        let group = searchActive && section == 0 ? filtered[row] : groups[section][row]
        cell.name.text = group.name
        cell.photo.sd_setImage(with: URL(string: group.photo), placeholderImage: UIImage(named: "vk"))

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 100, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
            cell.transform = CGAffineTransform(translationX: -100, y: 0)
        })
    }
}

extension GroupViewController: UISearchBarDelegate {
 
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
        
        filtered = groups[0].filter { $0.name.lowercased().contains(searchText.lowercased()) }

        searchActive = searchText.count == 0 ? false : true
        
        Session.instance.searchGroup(keyword: searchText) {[weak self] (groups) in
            self?.groups[1] = groups
            self?.tableView.reloadData()
        }
    }
}
