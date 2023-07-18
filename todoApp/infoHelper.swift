//
//  infoHelper.swift
//  todoApp
//
//  Created by 呼元祐樹 on 2023/07/18.
//

import Foundation
import RealmSwift
import NotificationCenter

class InfoHelper {
    
    let realm = try! Realm()
    
    func save(title:String,date:Date){
        let item = TodoItem()
        item.title = title
        item.date = date
        item.id = String(Int.random(in: 0...9999))
        try! realm.write{
            realm.add(item)
        }
        setNotification(item)
    }
    
    func dateToString(date:Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            return formatter.string(from:date)
        }
    
    func setNotification(_ item:TodoItem){
        let targetDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],from: item.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate,repeats: false)
        let content = UNMutableNotificationContent()
        content.title = item.title
        content.sound = .default
        let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func deleteItem(item:TodoItem,token:NotificationToken){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
        try! realm.write(withoutNotifying:[token]){
            realm.delete(item)
        }
    }
}
