//
//  NewTodoItemSettingViewModel.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation
import SwiftDate

protocol NewTodoItemSettingViewModel {
    
    var title: String { get }
    var deadLine: DateComponents { get }
    var repeatUnit: RepeatUnit { get }
    
    var yearList: [String] { get }
    var monthList: [String] { get }
    var dayList: [String] { get }
    
    mutating func setTitle(_ title: String)
    mutating func setDeadLine(year: Int, month: Int, day: Int)
    mutating func setRepeatUnit(_ repeatUnit: RepeatUnit)
    
    func makeNewTodoItem() -> TodoItem
}

struct DefaultNewTodoItemSettingViewModel: NewTodoItemSettingViewModel {
    
    private(set) var title: String
    private(set) var deadLine: DateComponents
    private(set) var repeatUnit: RepeatUnit
    
    private(set) var yearList: [String]
    private(set) var monthList: [String]
    private(set) var dayList: [String]
    
    init() {
        self.title = ""
        self.deadLine = .init()
        self.repeatUnit = .none
        
        let japan = Region(calendar: Calendars.gregorian, zone: Zones.asiaTokyo, locale: Locales.japanese)
        SwiftDate.defaultRegion = japan
        let today = DateInRegion(Date(), region: japan)
        let thisYear = today.year
        self.yearList = (thisYear...(thisYear + 10)).map { "\($0)" }
        self.monthList = (1...12).map { "\($0)"}
        self.dayList = (1...today.monthDays).map { "\($0)" }
    }
    
    mutating func setTitle(_ title: String) {
        self.title = title
    }
    
    mutating func setDeadLine(year: Int, month: Int, day: Int) {
        let deadLine = DateComponents(year: year, month: month, day: day)
        self.deadLine = deadLine
    }
    
    mutating func setRepeatUnit(_ repeatUnit: RepeatUnit) {
        self.repeatUnit = repeatUnit
    }
    
    func makeNewTodoItem() -> TodoItem {
        return TodoItem(title: title, deadLine: deadLine, repeatUnit: repeatUnit)
    }
}
