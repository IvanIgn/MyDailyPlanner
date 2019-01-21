//
//  Model.swift
//  MyDailyPlanner
//
//  Created by Ivan Ignatkov on 2019-01-11.
//  Copyright © 2019 TechCompetence. All rights reserved.
//

import Foundation

var ToDoItems: [[String: Any]] = [["Name": "Позвонить маме", "isCompleted": true], ["Name": "Дописать приложение", "isCompleted": false], ["Name": "Отметить", "isCompleted": false]]

func addItem(nameItem: String, isCompleted: Bool = false) {   ///adds new item to the table///
    ToDoItems.append(["Name": nameItem, "isCompleted": false ])
    saveData()
}

func removeItem(at index: Int) {  ///removes an item from the table///
    ToDoItems.remove(at: index)
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
    saveData()
    
    return (ToDoItems[item]["isCompleted"] as! Bool)
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
