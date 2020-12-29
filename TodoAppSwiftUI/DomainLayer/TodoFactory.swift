//
//  TodoFactory.swift
//  DomainLayer
//
//  Created by Kosuke Nishimura on 2020/12/29.
//

import Foundation

public enum TodoValidationError: Error {
    case textIsEmpty
    
    public var description: String {
        switch self {
        case .textIsEmpty:
            return "Empty Text is not allowed."
        }
    }
}

public struct TodoFactory {
    
    /// -Throws: `TodoValidationError`
    public static func makeTodo(id: UUID = .init(), text: String, isDone: Bool) throws -> Todo {
        guard !text.isEmpty else {
            throw TodoValidationError.textIsEmpty
        }
        
        return Todo(id: id, text: text, isDone: isDone)
    }
    
    public static func makeToggledTodo(_ todo: Todo) -> Todo {
        Todo(id: todo.id, text: todo.text, isDone: !todo.isDone)
    }
}
