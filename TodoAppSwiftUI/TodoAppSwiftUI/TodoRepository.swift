//
//  TodoRepository.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import Foundation
import Combine

final class TodoRepository: ObservableObject {
    
    private let storeKey = "AllTodos"
    private let userDefaults = UserDefaults.standard
    
    @Published private(set) var allTodos: [Todo] = [] {
        didSet {
            saveAllTodos()
        }
    }
    
    init() {
        guard let data = userDefaults.data(forKey: storeKey),
              let todos = try? JSONDecoder().decode([Todo].self, from: data) else { return }
        
        self.allTodos = todos
    }
    
    func add(_ todo: Todo) {
        allTodos.append(todo)
    }
    
    func deleteTodo(at offSets: IndexSet) {
        allTodos.remove(atOffsets: offSets)
    }
    
    func updateTodo(_ todo: Todo, to newTodo: Todo) {
        guard let index = allTodos.firstIndex(of: todo) else { return }
        allTodos[index] = newTodo
    }
    
    private func saveAllTodos() {
        guard let data = try? JSONEncoder().encode(allTodos) else { return }
        userDefaults.set(data, forKey: storeKey)
    }
}
