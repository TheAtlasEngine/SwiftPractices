//
//  NewTodoItemSettingViewModel.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

protocol NewTodoItemSettingViewModel {
    
    var title: String { get }
    var deadLine: Date { get }
    var repeatUnit: RepeatUnit { get }
    
    mutating func setTitle(_ title: String)
    mutating func setDeadLine(year: Int, month: Int, day: Int)
    mutating func setRepeatUnit(_ repeatUnit: RepeatUnit)
    
    func makeNewTodoItem() -> TodoItem
}

struct DefaultNewTodoItemSettingViewModel: NewTodoItemSettingViewModel {
    
    private(set) var title: String
    private(set) var deadLine: Date
    private(set) var repeatUnit: RepeatUnit
    
    mutating func setTitle(_ title: String) {
        self.title = title
    }
    
    mutating func setDeadLine(year: Int, month: Int, day: Int) {
        guard let deadLine = DateComponents(year: year, month: month, day: day).date else { return }
        self.deadLine = deadLine
    }
    
    mutating func setRepeatUnit(_ repeatUnit: RepeatUnit) {
        self.repeatUnit = repeatUnit
    }
    
    func makeNewTodoItem() -> TodoItem {
        return TodoItem(title: title, deadLine: deadLine, repeatUnit: repeatUnit)
    }
}
