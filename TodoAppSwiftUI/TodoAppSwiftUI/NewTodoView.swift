//
//  NewTodoView.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/25.
//

import SwiftUI

struct NewTodoView: View {
    
    @EnvironmentObject private var repository: TodoRepository
    
    @State private var shouldShowValidationError: Bool = false
    
    @State private var text: String = ""
    
    @Binding var isPresented: Bool
    
    private var okButton: some View {
        Button("OK") {
            guard isValidText() else {
                shouldShowValidationError = true
                return
            }
            addNewTodo()
            dismiss()
        }
        .alert(isPresented: $shouldShowValidationError) {
            Alert(title: Text("Empty title is not allowed."))
        }
    }
    
    var body: some View {
        NavigationView {
            TextField("", text: $text)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .navigationBarItems(trailing: okButton)
        }
    }
}

private extension NewTodoView {
    
    func isValidText() -> Bool {
        !text.isEmpty
    }
    
    func addNewTodo() {
        let newTodo = Todo(text: text, isDone: false)
        repository.add(newTodo)
    }
    
    func dismiss() {
        isPresented = false
    }
}
