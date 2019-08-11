//
//  DataSelectState.swift
//  CellSelectionStyleWhenEditing
//
//  Created by Kosuke Nishimura on 2019/06/02.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

struct DataSelectState {
    let allData: [String]
    var selectedData = [String]()
    
    init(allData: [String]) {
        self.allData = allData
    }
    
    func isSelecting(data: String) -> Bool {
        return selectedData.contains(data)
    }
    
    mutating func changeState(of data: String) {
        if isSelecting(data: data) {
            selectedData.remove(at: selectedData.firstIndex(of: data)!)
        } else {
            selectedData.append(data)
        }
    }
}
