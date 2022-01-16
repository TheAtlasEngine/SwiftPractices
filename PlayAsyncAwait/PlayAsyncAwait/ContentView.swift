//
//  ContentView.swift
//  PlayAsyncAwait
//
//  Created by Kosuke Nishimura on 2022/01/16.
//

import SwiftUI

struct ContentView: View {
    
    let repository = DefaultWeatherDataRepository()
    
    @State var date: String = ""
    @State var region: String = ""
    @State var headline: String = ""
    @State var detail: String = ""
    
    @State var isAlertPresented: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("報告日時") { Text(date) }
                Section("対象地域") { Text(region) }
                Section("ヘッドライン") { Text(headline) }
                Section("詳細") { Text(detail) }
            }
            .listStyle(.grouped)
            .navigationTitle("天気予報")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("reload") {
                    Task { await fetch() }
                }
            }
        }
        .task {
            await fetch()
        }
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK")) {
                    isAlertPresented = false
                }
            )
        }
    }
    
    func fetch() async {
        
        do {
            let weatherData = try await repository.fetch()
            
            date = weatherData.reportDatetime
            region = weatherData.targetArea
            headline = weatherData.headlineText
            detail = weatherData.text
        } catch {
            errorMessage = error.localizedDescription
            isAlertPresented = true
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
