//
//  NewTodoView.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/25.
//

import DomainLayer
import SwiftUI

struct NewTodoView: View {
    
    @EnvironmentObject private var repository: TodoRepository
    
    @State private var shouldShowValidationError: Bool = false
    @State private var validationError: TodoValidationError = .textIsEmpty
    
    @State private var text: String = ""
    
    @Binding var isPresented: Bool
    
    private var okButton: some View {
        Button("OK") {
            addNewTodo()
        }
        .alert(isPresented: $shouldShowValidationError) {
            Alert.make(with: validationError)
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
    
    func addNewTodo() {
        
        let result = TodoFactory.makeTodo(text: text, isDone: false)
        
        switch result {
        case .success(let newTodo):
            repository.add(newTodo)
            dismiss()
        case .failure(let error):
            shouldShowValidationError = true
            validationError = error
        }
    }
    
    func dismiss() {
        isPresented = false
    }
}
