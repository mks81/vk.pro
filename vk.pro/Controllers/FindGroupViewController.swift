//
//  FindGroupViewController.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 18/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class FindGroupViewController: UITableViewController {
    
    var groups: [GroupModel] = [
        GroupModel(name: "Клопс", photo: "klops"),
        GroupModel(name: "ЯПлакаль!", photo: "yap"),
        GroupModel(name: "Рыбалка в Калининграде", photo: "fish"),
        GroupModel(name: "СПОРТ - ЭТО ЖИЗНЬ", photo: "sport"),
        GroupModel(name: "Английский для лентяев", photo: "english")
    ]

    var completionBlock: ((GroupModel) ->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { return UITableViewCell() }

        cell.name.text = groups[indexPath.row].name
        cell.photo.image = UIImage(named: groups[indexPath.row].photo)

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
        if segue.identifier == "UnwindToGroupSegue",
            let groupController = segue.destination as? GroupViewController,
            let cell = sender as? GroupCell,
            let indexPath = tableView.indexPath(for: cell),
            !groupController.groups.contains(where: { $0.name == cell.name.text }) {
            
            groupController.groups.append(groups[indexPath.row])
            groupController.tableView.insertRows(at: [IndexPath(item: groupController.groups.count - 1, section: 0)], with: .automatic)
            
            //я просто передал группу в контроллер для вывода в консоль, потому как не думаю что в данном случае этот вариант удобней
            completionBlock?(groups[indexPath.row])
        }
    }
}
