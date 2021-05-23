//
//  ContentView.swift
//  CardView
//
//  Created by Kosuke Nishimura on 2021/05/23.
//

import SwiftUI

struct ContentView: View {
    
    let texts = [
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
        "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        "Contrary to popular belief, Lorem Ipsum is not simply random text. ",
    ]
    
    var body: some View {
        List(texts, id: \.self) { text in
            CardView(
                cornerRadius: 10,
                borderWidth: 1,
                borderColor: .gray
            ) {
                HStack {
                    Text(text).padding()
                    Spacer()
                }
            }
        }
        .listStyle(SidebarListStyle())  // Hide the separators
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
