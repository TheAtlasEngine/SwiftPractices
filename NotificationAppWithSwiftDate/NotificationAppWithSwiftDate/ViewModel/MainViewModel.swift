//
//  MainViewModel.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

protocol MainViewModel {
    
    var todoItems: [TodoItem] { get }
    
    mutating func add(_ todoItem: TodoItem)
    mutating func deleteTodoItem(at index: Int)
    
    func todoItem(forRowAt indexPath: IndexPath) -> TodoItem
}

struct DefaultMainViewModel: MainViewModel {
    
    private(set) var todoItems: [TodoItem]
    
    init(todoItems: [TodoItem]) {
        self.todoItems = todoItems
    }
    
    mutating func add(_ todoItem: TodoItem) {
        todoItems.append(todoItem)
    }
    
    mutating func deleteTodoItem(at index: Int) {
        todoItems.remove(at: index)
    }
    
    func todoItem(forRowAt indexPath: IndexPath) -> TodoItem {
        return todoItems[indexPath.row]
    }
}
