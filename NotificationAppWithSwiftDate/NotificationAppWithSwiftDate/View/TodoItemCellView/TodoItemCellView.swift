//
//  TodoItemCellView.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class TodoItemCellView: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var deadLineLabel: UILabel!
    @IBOutlet private weak var repeatUnitLabel: UILabel!
    
    static let id = "TodoItemCellView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(_ viewModel: TodoItemCellViewModel) {
        
        titleLabel.text = viewModel.title
        repeatUnitLabel.text = viewModel.repeatUnit.rawValue
        
        let deadLine = viewModel.deadLine
        if let year = deadLine.year, let month = deadLine.month, let day = deadLine.day {
            deadLineLabel.text = "year: \(year) month: \(month) day: \(day)"
        } else {
            repeatUnitLabel.text = ""
        }
    }
    
}
