//
//  Todo.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import Foundation

struct Todo: Codable, Hashable {

    let id: UUID
    let text: String
    let isDone: Bool
    
    init(id: UUID = .init(), text: String, isDone: Bool) {
        self.id = id
        self.text = text
        self.isDone = isDone
    }
}
