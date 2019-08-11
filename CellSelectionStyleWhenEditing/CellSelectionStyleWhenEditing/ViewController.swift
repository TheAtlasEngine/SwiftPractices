//
//  ViewController.swift
//  CellSelectionStyleWhenEditing
//
//  Created by Kosuke Nishimura on 2019/05/24.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let cellId = "cell"
    static let id = "VC"
    
    private let allData: [String] = (1...21).map {
        return "cell text \($0)"
    }
    
    lazy var dataSelectState: DataSelectState = {
        return DataSelectState(allData: self.allData)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = allData[indexPath.row]
        cell.tintColor = UIColor.orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .checkmark
    }
    
    
}
