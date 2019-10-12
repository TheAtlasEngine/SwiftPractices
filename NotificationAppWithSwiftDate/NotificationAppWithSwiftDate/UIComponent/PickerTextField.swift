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
    private(set) var dataList: [String]
    
    init(dataList: [String]) {
        self.dataList = dataList
        super.init(frame: .zero)
        
        setupToolbar()
        setupPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            barButtonSystemItem: .done,
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
