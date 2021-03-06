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
    @IBOutlet private weak var repeatUnitPickerTextField: PickerTextField!
    @IBOutlet private weak var newTodoItemCreationButton: UIButton!
    
    private var viewModel: NewTodoItemSettingViewModel!
    
    enum Event {
        case add(TodoItem)
    }
    
    var onEvent: ((Event) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
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
        guard let repeatUnitString = repeatUnitPickerTextField.text else { return }
        
        guard !title.isEmpty else { return }
        
        guard let year = Int(yearString) else { return }
        guard let month = Int(monthString) else { return }
        guard let day = Int(dayString) else { return }
        
        guard let repeatUnit = RepeatUnit(rawValue: repeatUnitString) else { return }
        
        viewModel.setTitle(title)
        viewModel.setDeadLine(year: year, month: month, day: day)
        viewModel.setRepeatUnit(repeatUnit)
        
        let todoItem = viewModel.makeNewTodoItem()
        onEvent?(.add(todoItem))
        dismiss(animated: true, completion: nil)
    }
}

private extension NewTodoItemSettingViewController {
    
    func setUpTextFields() {
        titleTextField.becomeFirstResponder()
        
        titleTextField.delegate = self
        titleTextField.tag = 0
        
        yearPickerTextField.delegate = self
        yearPickerTextField.tag = 1
        
        monthPickerTextField.delegate = self
        monthPickerTextField.tag = 2
        
        dayPickerTextField.delegate = self
        dayPickerTextField.tag = 3
        
        repeatUnitPickerTextField.delegate = self
        repeatUnitPickerTextField.tag = 4
    }
    
    func bind() {
        newTodoItemCreationButton.setBackgroundColor(color: .creationButtonDefault, forState: .normal)
        newTodoItemCreationButton.setBackgroundColor(color: .creationButtonHighlighted, forState: .highlighted)
        
        viewModel = DefaultNewTodoItemSettingViewModel()
        
        yearPickerTextField.setDataList(viewModel.yearList)
        monthPickerTextField.setDataList(viewModel.monthList)
        dayPickerTextField.setDataList(viewModel.dayList)
        
        let repeatUnitStrings = RepeatUnit.allCases.map { $0.rawValue }
        repeatUnitPickerTextField.setDataList(repeatUnitStrings)
    }
}

extension NewTodoItemSettingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}
