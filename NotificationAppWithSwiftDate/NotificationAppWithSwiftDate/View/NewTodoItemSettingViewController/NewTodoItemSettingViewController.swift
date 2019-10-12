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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismiss(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}
