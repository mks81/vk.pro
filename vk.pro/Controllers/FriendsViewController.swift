//
//  FriendsViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    var index = 0
    var rowsInSection: [Int] = Array()
    var alphabet: [String] = Array()
    var friends: [UserModel] = [
        UserModel(name: "Виталий Бутерин", photo: "buterin"),
        UserModel(name: "Elon Musk", photo: "musk"),
        UserModel(name: "Владимир Путин", photo: "putin"),
        UserModel(name: "Павел Дуров", photo: "durov")
    ].sorted(by: {$0.name < $1.name})
    

    func getTitles() {
        alphabet.append(String(friends[0].name.first!))
        var rowsCount = 1
        for i in 1..<friends.count {
            let leftValue = friends[i - 1].name.first
            let rightValue = friends[i].name.first
            if leftValue == rightValue {
                rowsCount += 1
                continue
            }
            alphabet.append(String(rightValue!))
            rowsInSection.append(rowsCount)
            rowsCount = 1
        }
        rowsInSection.append(rowsCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTitles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return alphabet
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return alphabet.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSection[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(alphabet[section])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId, for: indexPath) as? UserCell else { return UITableViewCell() }
        
        cell.name.text = friends[index].name
        cell.photo.image = UIImage(named: friends[index].photo)
        index += 1
        
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
        photoController.photo = friends[(indexPath!.section + 1) * (indexPath!.row + 1) - 1].photo
    }
}
