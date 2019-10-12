//
//  NewTodoItemSettingNavigationViewController.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class NewTodoItemSettingNavigationViewController: UINavigationController {
    
    static func instantiateFromStoryboard() -> NewTodoItemSettingNavigationViewController {
        let storyboard = UIStoryboard(name: "NewTodoItemSettingViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        guard let navigationController = viewController as? NewTodoItemSettingNavigationViewController else {
            fatalError()
        }
        return navigationController
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: NewTodoItemSettingViewController())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
