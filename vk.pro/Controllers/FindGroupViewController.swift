//
//  FindGroupViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import SDWebImage

class FindGroupViewController: UITableViewController, UISearchBarDelegate {
    
    var groups: [Group] = []

    var searchActive = false
    
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
        Session.instance.searchGroup(keyword: searchText) {[weak self] (groups) in
            self?.groups = groups
            self?.tableView.reloadData()
        }
        
        searchActive = searchText.count == 0 ? false : true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { return UITableViewCell() }

        let group = groups[indexPath.row]
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "UnwindToGroupSegue",
//            let groupController = segue.destination as? GroupViewController,
//            let cell = sender as? GroupCell,
//            let indexPath = tableView.indexPath(for: cell),
//            !groupController.groups.contains(where: { $0.name == cell.name.text }) {
//
//            groupController.groups.append(groups[indexPath.row])
//            groupController.tableView.insertRows(at: [IndexPath(item: groupController.groups.count - 1, section: 0)], with: .automatic)
//        }
    }
}
