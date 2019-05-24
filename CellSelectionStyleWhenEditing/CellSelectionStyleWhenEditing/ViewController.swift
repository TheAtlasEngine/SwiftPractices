//
//  ViewController.swift
//  CellSelectionStyleWhenEditing
//
//  Created by Kosuke Nishimura on 2019/05/24.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let cellId = "cell"
    private var isEditingMode = true
    
    private let dummyData = ["cell text 1",
                             "cell text 2",
                             "cell text 3",
                             "cell text 4",
                             "cell text 5",
                             "cell text 6",
                             "cell text 7",
                             "cell text 8",
                             "cell text 9",
                             "cell text 10",
                             "cell text 11",
                             "cell text 12",
                             "cell text 13",
                             "cell text 14",
                             "cell text 15",
                             "cell text 16",
                             "cell text 17",
                             "cell text 18",
                             "cell text 19",
                             "cell text 20",
                             "cell text 21"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelection = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toEditMode))
    }
    
    @objc private func toEditMode() {
        tableView.setEditing(isEditingMode, animated: true)
        isEditingMode = !isEditingMode
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dummyData[indexPath.row]
        cell.tintColor = UIColor.orange
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
}
