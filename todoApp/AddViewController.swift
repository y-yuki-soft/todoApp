//
//  AddViewController.swift
//  todoApp
//
//  Created by 呼元祐樹 on 2023/07/18.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var itemField: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.timeZone = TimeZone.current
        datePicker.locale = Locale.current
    }
    
    @IBAction func onAdd(_ sender: Any) {
        InfoHelper().save(title:itemField.text!, date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
