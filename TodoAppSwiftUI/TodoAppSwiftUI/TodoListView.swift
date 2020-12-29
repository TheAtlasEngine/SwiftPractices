//
//  TodoListView.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import SwiftUI

struct TodoListView: View {
    
    @State private var editMode: EditMode = .inactive
    
    @State private var isNewTodoViewPresented: Bool = false
    
    @EnvironmentObject private var repository: TodoRepository
    
    var body: some View {
        NavigationView {
            List {
                ForEach(repository.allTodos, id: \.self) { (todo) in
                    TodoListRowView(todo: todo)
                }
                .onDelete { repository.deleteTodo(at: $0) }
            }
            .navigationTitle("Todo List")
            .navigationBarItems(
                leading: EditButton(),
                trailing: addButton
            )
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        Button(
            action: {
                isNewTodoViewPresented = true
                editMode = .inactive
            },
            label: { Image(systemName: "plus") }
        )
        .sheet(
            isPresented: $isNewTodoViewPresented,
            content: { NewTodoView(isPresented: $isNewTodoViewPresented) }
        )
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(TodoRepository())
    }
}
