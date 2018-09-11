//
//  ItemTableViewModel.swift
//  MyToDo
//
//  Created by Funmi Adewodu on 11/09/2018.
//  Copyright © 2018 Angie Mugo. All rights reserved.
//

import Foundation

class ItemTableViewModel {
    
    var alertTitle = "New To-Do Item"
    var alertMessage = "Insert the title of the new to-do item:"
    var actionTitle = "OK"
    
    var todoList = [ToDoItem]()
    private let defaults = UserDefaults.standard

    init() {
        fetchData()
    }
    
    func addToDo(_ todoTitle: String) {
        todoList.append(ToDoItem(title: todoTitle))
    }
    
    func deleteItem(_ item: Int) {
        todoList.remove(at: item)
    }
    
    func toggleDone(row: Int) {
        todoList[row].done = !todoList[row].done
    }
    
    //MARK: fetch data from user defaults
    func fetchData() {
        
        if let list = defaults.value(forKey: "encodedList") as? [[String: Any]] {
            
            for item in list {
                guard let todoItem = ToDoItem(item) else { return }
                
                todoList.append(todoItem)
            }
        }
    }
    
    //MARK: Save data to user defaults
    func saveData() {
        
        var encodedList = [[String: Any]]()
        
        for item in todoList {
            encodedList.append(item.toPropertyList())
        }
        
        defaults.set(encodedList, forKey: "encodedList")
    }
}
