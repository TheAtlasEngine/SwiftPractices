//
//  ViewController.swift
//  AutoLayoutProgrammatically
//
//  Created by Kosuke Nishimura on 2019/05/25.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private var tableView: UITableView!
    private var buttonContainer: UIView!
    private var button: UIButton!
    private let cellId = "cell"
    
    private var buttonContainerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Animation Using Variable Auto Layout"

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        button = UIButton(type: .system)
        button.setTitle("Hide this buttom", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(hideBottomButton), for: .touchUpInside)
        
        buttonContainer = UIView()
        buttonContainer.backgroundColor = .gray
        
        self.view.addSubview(tableView)
        self.view.addSubview(buttonContainer)
        buttonContainer.addSubview(button)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        buttonContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        buttonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonContainerHeightConstraint = buttonContainer.heightAnchor.constraint(equalToConstant: 0)
        buttonContainerHeightConstraint.isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: 20).isActive = true
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "show", style: .plain, target: self, action: #selector(showBottomButton))
    }
    @objc private func showBottomButton() {
        buttonContainerHeightConstraint.constant = 100
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func hideBottomButton() {
        buttonContainerHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "cell text number \(indexPath.row)"
        return cell
    }
}
