//
//  MovieListItem.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI

struct MovieListItem: View {
    let id = UUID()
    
    let movie: Movie
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            if let imageURL = movie.imageURL {
                AsyncImage(url: imageURL)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                if let name = movie.name {
                    Text(name)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                if let explanation = movie.explanation {
                    Text(explanation)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Toggle(isOn: $isSelected) {}
            .toggleStyle(CheckBoxToogleStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
