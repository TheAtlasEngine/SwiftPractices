//
//  TodoRepository.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import Foundation
import Combine

public final class TodoRepository: ObservableObject {
    
    private let storeKey = "AllTodos"
    private let userDefaults = UserDefaults.standard
    
    @Published public private(set) var allTodos: [Todo] = [] {
        didSet {
            saveAllTodos()
        }
    }
    
    public init() {
        guard let data = userDefaults.data(forKey: storeKey),
              let todos = try? JSONDecoder().decode([Todo].self, from: data) else { return }
        
        self.allTodos = todos
    }
    
    public func add(_ todo: Todo) {
        allTodos.append(todo)
    }
    
    public func deleteTodo(at index: Int) {
        allTodos.remove(at: index)
    }
    
    public func updateTodo(_ todo: Todo, to newTodo: Todo) {
        guard let index = allTodos.firstIndex(of: todo) else { return }
        allTodos[index] = newTodo
    }
    
    private func saveAllTodos() {
        guard let data = try? JSONEncoder().encode(allTodos) else { return }
        userDefaults.set(data, forKey: storeKey)
    }
}
