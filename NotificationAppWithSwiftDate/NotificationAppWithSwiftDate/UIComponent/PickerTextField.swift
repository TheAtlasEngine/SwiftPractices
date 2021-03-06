//
//  PickerTextField.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class PickerTextField: UITextField {
    
    private var pickerView: UIPickerView!
    private(set) var dataList: [String]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupToolbar()
        setupPickerView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        doneSelectRow()
    }
    
    func setDataList(_ dataList: [String]) {
        self.dataList = dataList
    }
}

private extension PickerTextField {
    
    func setupToolbar() {
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)
        )
        
        let cancelItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissKeyboard)
        )
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneItem = UIBarButtonItem(
            barButtonSystemItem: .fastForward,
            target: self,
            action: #selector(doneSelectRow)
        )
        
        toolbar.setItems([cancelItem, spacer, doneItem], animated: false)
        
        inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc func doneSelectRow() {
        endEditing(true)
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        text = dataList[selectedRow]
        
        if let nextField = superview?.viewWithTag(tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
    }
    
    func setupPickerView() {
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        
        inputView = pickerView
    }
}

extension PickerTextField: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
}

extension PickerTextField: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = dataList[row]
    }
}
