//
//  Model.swift
//  MyDailyPlanner
//
//  Created by Ivan Ignatkov on 2019-01-11.
//  Copyright © 2019 TechCompetence. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


var ToDoItems: [[String: Any]] = [["Name": "a", "isCompleted": true, "Description": "description"], ["Name": "b", "isCompleted": false, "Description": "description"], ["Name": "c", "isCompleted": false, "Description": "description"]]




func addItem(nameItem: String, isCompleted: Bool = false) {   ///adds new item to the table///
    ToDoItems.append(["Name": nameItem, "isCompleted": false, "Description": ""])
    setBadge()
    saveData()
}


func removeItem(at index: Int) {  ///removes an item from the table///
    ToDoItems.remove(at: index)
    setBadge()
    saveData()
}

func moveItemFrom(fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
    saveData()
}

func changeState(at item:  Int) -> Bool {
    ToDoItems[item]["isCompleted"] =  !(ToDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    saveData()
    
    return (ToDoItems[item]["isCompleted"] as! Bool)
}

func setDescription(_ text: String, atItem item: Int) {
    ToDoItems[item]["Description"] = text
    saveData()
}

func saveData() {  ///saves the data in the memory///
    UserDefaults.standard.set(ToDoItems, forKey: "ToDoDataKey")
    UserDefaults.standard.synchronize()
    
}

func loadData() {  ///loads the data from the memory///
    if let array =  UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
        ToDoItems = array
    } else {
        ToDoItems = []
    }
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled  {
            print("Notification is accepted")
        } else {
            print("Notification is canceled")
        }
    }
}

func setBadge() {
    var totalNumber = 0
    for item in ToDoItems {
        if (item["isCompleted"] as? Bool ) == false {
            totalNumber = totalNumber + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalNumber
}
