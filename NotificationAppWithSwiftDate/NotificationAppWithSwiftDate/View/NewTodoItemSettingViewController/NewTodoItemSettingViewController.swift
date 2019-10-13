//
//  NewTodoItemSettingViewController.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class NewTodoItemSettingViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var yearPickerTextField: PickerTextField!
    @IBOutlet private weak var monthPickerTextField: PickerTextField!
    @IBOutlet private weak var dayPickerTextField: PickerTextField!
    @IBOutlet weak var repeatUnitPickerTextField: PickerTextField!
    
    private var viewModel: NewTodoItemSettingViewModel!
    
    enum Event {
        case add(TodoItem)
    }
    
    var onEvent: ((Event) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewTodoItem(_ sender: Any) {
        view.endEditing(true)
        
        guard let title = titleTextField.text else { return }
        guard let yearString = yearPickerTextField.text else { return }
        guard let monthString = monthPickerTextField.text else { return }
        guard let dayString = dayPickerTextField.text else { return }
        
        guard let year = Int(yearString) else { return }
        guard let month = Int(monthString) else { return }
        guard let day = Int(dayString) else { return }
        
        guard !title.isEmpty else { return }
        
        viewModel.setTitle(title)
        viewModel.setDeadLine(year: year, month: month, day: day)
        viewModel.setRepeatUnit(.none)
        
        let todoItem = viewModel.makeNewTodoItem()
        onEvent?(.add(todoItem))
        dismiss(animated: true, completion: nil)
    }
}

private extension NewTodoItemSettingViewController {
    
    func bind() {
        viewModel = DefaultNewTodoItemSettingViewModel()
        
        yearPickerTextField.setDataList(viewModel.yearList)
        monthPickerTextField.setDataList(viewModel.monthList)
        dayPickerTextField.setDataList(viewModel.dayList)
    }
}
