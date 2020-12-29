//
//  TodoListRowView.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/25.
//

import SwiftUI

struct TodoListRowView: View {
    
    @EnvironmentObject private var repository: TodoRepository
    
    let todo: Todo

    @State private var text: String

    init(todo: Todo) {
        self.todo = todo
        self._text = State(initialValue: todo.text)
    }

    private var textField: some View {
        TextField("", text: $text, onEditingChanged: { _ in }) {
            if text.isEmpty {
                deleteTodo()
            } else {
                editText(text)
            }
        }
    }
    
    var body: some View {
        HStack {
            textField
            Spacer()
            checkmark(isDone: todo.isDone)
        }
    }
    
    private func checkmark(isDone: Bool) -> some View {
        Image(systemName: isDone ? "checkmark.square" : "square")
            .onTapGesture { toggleCompletion() }
    }
    
    private func toggleCompletion() {
        let newTodo = Todo(
            id: todo.id,
            text: todo.text,
            isDone: !todo.isDone
        )
        repository.updateTodo(todo, to: newTodo)
    }
    
    private func editText(_ newText: String) {
        let newTodo = Todo(id: todo.id, text: newText, isDone: todo.isDone)
        repository.updateTodo(todo, to: newTodo)
    }
    
    private func deleteTodo() {
        guard let index = repository.allTodos.firstIndex(of: todo) else { return }
        repository.deleteTodo(at: IndexSet(integer: index))
    }
}