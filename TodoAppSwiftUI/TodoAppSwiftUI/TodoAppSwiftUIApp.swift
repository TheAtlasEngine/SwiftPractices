//
//  TodoAppSwiftUIApp.swift
//  TodoAppSwiftUI
//
//  Created by Kosuke Nishimura on 2020/12/24.
//

import SwiftUI

@main
struct TodoAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environmentObject(TodoRepository())
        }
    }
}
