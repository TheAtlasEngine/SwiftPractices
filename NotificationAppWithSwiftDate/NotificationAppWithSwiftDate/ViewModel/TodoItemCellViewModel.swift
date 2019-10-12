//
//  TodoItemCellViewModel.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

protocol TodoItemCellViewModel {

    var title: String { get }
    var deadLine: Date { get }
    var repeatUnit: String { get }
}

struct DefaultTodoItemCellViewModel: TodoItemCellViewModel {
    
    let title: String
    let deadLine: Date
    let repeatUnit: String
    
    init(todoItem: TodoItem) {
        self.title = todoItem.title
        self.deadLine = todoItem.deadLine
        self.repeatUnit = todoItem.repeatUnit
    }
}
