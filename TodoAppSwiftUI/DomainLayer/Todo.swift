//
//  Todo.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import Foundation

public struct Todo: Codable, Hashable {

    public let id: UUID
    public let text: String
    public let isDone: Bool
    
    internal init(id: UUID = .init(), text: String, isDone: Bool) {
        self.id = id
        self.text = text
        self.isDone = isDone
    }
}
