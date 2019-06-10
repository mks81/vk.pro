//
//  FriendsViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    var friends: [UserModel] = [
        UserModel(name: "Виталий Бутерин", photo: "buterin"),
        UserModel(name: "Владимир Доброжинский", photo: "vovan"),
        UserModel(name: "Надежда Адаменко", photo: "nadya"),
        UserModel(name: "Ирина Стирманова", photo: "ira"),
        UserModel(name: "Денис Хрисанфов", photo: "den"),
        UserModel(name: "Elon Musk", photo: "musk"),
        UserModel(name: "Владимир Путин", photo: "putin"),
        UserModel(name: "Василий Жуков", photo: "vasek"),
        UserModel(name: "Евгения Иванова", photo: "phuket"),
        UserModel(name: "Роман Михайлов", photo: "roma"),
        UserModel(name: "Павел Дуров", photo: "durov")
        ].sorted(by: {$0.name.split(separator: " ")[1] < $1.name.split(separator: " ")[1]})
    
    var titleForSection = [String]()
    var items = [[UserModel]]()
    
    var searchActive = false
    var filtered = [UserModel]()

    func prepareData() {
        var section = 0
        titleForSection.append(String(friends[0].name.split(separator: " ")[1].first!))
        items.append([UserModel]())
        items[section].append(friends[0])
        
        for row in 1..<friends.count {
            let leftValue = friends[row - 1].name.split(separator: " ")[1].first
            let rightValue = friends[row].name.split(separator: " ")[1].first
            if leftValue == rightValue {
                items[section].append(friends[row])
            } else {
                titleForSection.append(String(rightValue!))
                section += 1
                items.append([UserModel]())
                items[section].append(friends[row])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareData()
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
        
        filtered = friends.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
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
        cell.name.text = friend.name
        cell.photo.image = UIImage(named: friend.photo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.transform = CGAffineTransform(translationX: 100, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            cell.transform = CGAffineTransform(translationX: -100, y: 0)
        })
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let photoController = segue.destination as! PhotoViewController
        let cell = sender as! UserCell
        let indexPath = tableView.indexPath(for: cell)
        photoController.photo = items[indexPath!.section][indexPath!.row].photo
    }
}
