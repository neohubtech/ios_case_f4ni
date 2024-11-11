//
//  CustomBagdeModifier.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI


struct CustomBagdeModifier: ViewModifier {
    
    let count: Int
    
    func body(content: Content) -> some View {
        if count > 0 {
            ZStack(alignment: .topTrailing) {
                content
                Text(count, format: .number)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(Color.red)
                    .frame(height: 17)
                    .clipShape(Capsule())
                    .offset(x: 5, y: -5)
            }
        } else {
            content
        }
    }
}

extension View {
    func badge(count: Int) -> some View {
        modifier(CustomBagdeModifier(count: count))
    }
}
