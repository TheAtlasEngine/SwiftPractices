//
//  TodoItem.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

struct TodoItem {
    let title: String
    let deadLine: Date
    let repeatUnit: String
    
    init(title: String, deadLine: Date, repeatUnit: RepeatUnit) {
        self.title = title
        self.deadLine = deadLine
        self.repeatUnit = repeatUnit.rawValue
    }
}
