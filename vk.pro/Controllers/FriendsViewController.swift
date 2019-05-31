//
//  FriendsViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {

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
        ].sorted(by: {$0.name < $1.name})
    
    var titleForSection = [String]()
    var items = [[UserModel]]()

    func prepareData() {
        var section = 0
        titleForSection.append(String(friends[0].name.first!))
        items.append([UserModel]())
        items[section].append(friends[0])
        
        for row in 1..<friends.count {
            let leftValue = friends[row - 1].name.first
            let rightValue = friends[row].name.first
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

    // MARK: - Table view data source

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleForSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleForSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(titleForSection[section])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId, for: indexPath) as? UserCell else { return UITableViewCell() }
        
        let section = indexPath.section
        let row = indexPath.row
        let friend = items[section][row]
        cell.name.text = friend.name
        cell.photo.image = UIImage(named: friend.photo)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let photoController = segue.destination as! PhotoViewController
        let cell = sender as! UserCell
        let indexPath = tableView.indexPath(for: cell)
        photoController.photo = items[indexPath!.section][indexPath!.row].photo
    }
}
