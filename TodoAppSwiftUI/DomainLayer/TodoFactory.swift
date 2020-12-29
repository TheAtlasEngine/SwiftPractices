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

    public static func makeTodo(
        id: UUID = .init(),
        text: String,
        isDone: Bool
    ) -> Result<Todo, TodoValidationError> {
        guard !text.isEmpty else {
            return .failure(.textIsEmpty)
        }
        
        return .success(Todo(id: id, text: text, isDone: isDone))
    }
    
    public static func makeToggledTodo(_ todo: Todo) -> Todo {
        Todo(id: todo.id, text: todo.text, isDone: !todo.isDone)
    }
}
