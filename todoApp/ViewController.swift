//
//  ViewController.swift
//  todoApp
//
//  Created by 呼元祐樹 on 2023/07/13.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemList:Results<TodoItem>!
    let realm = try! Realm()
    var token:NotificationToken!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
        token = realm.observe { notification, realm in
            //変更があった場合にここが実行される
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            InfoHelper().deleteItem(item:itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
                                    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = itemList[indexPath.row]
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = InfoHelper().dateToString(date:item.date)
        return cell!
    }
}

