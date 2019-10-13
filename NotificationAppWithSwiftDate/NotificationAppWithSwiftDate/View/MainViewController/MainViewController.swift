//
//  MainViewController.swift
//  NotificationAppWithSwiftDate
//
//  Created by Kosuke Nishimura on 2019/10/12.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var  viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DefaultMainViewModel(
            todoItems: [
                TodoItem(title: "hoge",deadLine: DateComponents(year: 2019, month: 11, day: 1),repeatUnit: .none)
            ]
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TodoItemCellView.id, bundle: nil), forCellReuseIdentifier: TodoItemCellView.id)
    }

    @IBAction func presentNewTodoItemSettingView(_ sender: Any) {
        let nextViewController = NewTodoItemSettingNavigationViewController.instantiateFromStoryboard()
        guard let newTodoSettingVC = nextViewController.topViewController as? NewTodoItemSettingViewController else {
            fatalError()
        }
        newTodoSettingVC.onEvent = { [weak self] event in
            switch event {
            case .add(let todoItem):
                self?.viewModel.add(todoItem)
            }
            self?.tableView.reloadData()
        }
        
        present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func reload(_ sender: Any) {
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func cellViewModel(forRowAt indexPath: IndexPath) -> TodoItemCellViewModel {
        let todoItem = viewModel.todoItem(forRowAt: indexPath)
        return DefaultTodoItemCellViewModel(todoItem: todoItem)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemCellView.id, for: indexPath) as? TodoItemCellView else {
            return UITableViewCell()
        }
        cell.bind(cellViewModel(forRowAt: indexPath))
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, _) in
            self?.viewModel.deleteTodoItem(at: indexPath.row)
            tableView.reloadData()
        }
        
        return .init(actions: [delete])
    }
}
