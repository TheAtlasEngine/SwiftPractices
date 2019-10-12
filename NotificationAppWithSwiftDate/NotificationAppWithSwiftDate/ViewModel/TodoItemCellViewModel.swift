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
    var deadLine: DateComponents { get }
    var repeatUnit: RepeatUnit { get }
}

struct DefaultTodoItemCellViewModel: TodoItemCellViewModel {
    
    let title: String
    let deadLine: DateComponents
    let repeatUnit: RepeatUnit
    
    init(todoItem: TodoItem) {
        self.title = todoItem.title
        self.deadLine = todoItem.deadLine
        self.repeatUnit = todoItem.repeatUnit
    }
}
