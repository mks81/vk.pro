//
//  GroupViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class GroupViewController: UITableViewController, UISearchBarDelegate {

    var groups: [GroupModel] = [
        GroupModel(name: "iOS dev.", photo: "ios"),
        GroupModel(name: "Новости", photo: "news"),
        GroupModel(name: "/dev/null", photo: "dev"),
        GroupModel(name: "Книга рекордов", photo: "book")
    ]
    
    var searchActive = false
    var filtered = [GroupModel]()
    
    @IBAction func unwindToGroup(unwindSeque: UIStoryboardSegue) {
        //tableView.reloadData()
        //tableView.insertRows(at: [IndexPath(item: groups.count - 1, section: 0)], with: .automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        filtered = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        searchActive = searchText.count == 0 ? false : true
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchActive ? filtered.count : groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { return UITableViewCell() }

        let group = searchActive ? filtered[indexPath.row] : groups[indexPath.row]
        cell.name.text = group.name
        cell.photo.image = UIImage(named: group.photo)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
