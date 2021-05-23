//
//  CardView.swift
//  CardView
//
//  Created by Kosuke Nishimura on 2021/05/23.
//

import SwiftUI

/// Note: [Reference](https://www.appcoda.com/swiftui-card-view/)
struct CardView<Content: View>: View {
    
    private let content: Content
    
    private let cornerRadius: CGFloat
    private let borderWidth: CGFloat
    private let borderColor: Color
    
    init(
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        borderColor: Color,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            cornerRadius: 10,
            borderWidth: 1,
            borderColor: .black
        ) {
            HStack {
                Text("HELLO WORLD!!").padding()
                Spacer()
            }
        }
    }
}

