//
//  SavedMoviesView.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI

struct SavedMoviesView: View {
    
    var movies: [Movie]
    
    var body: some View {
        VStack {
            Text("Favorite Movies")
                .bold()
            if movies.isEmpty {
                ContentUnavailableView(
                    "You Don't Have Favorite Movies",
                    systemImage: "square.3.layers.3d.slash"
                )
            } else {
                let layout = [
                    GridItem(.fixed(100)),
                    GridItem(.adaptive(minimum: 64, maximum: 100)),
                    GridItem(.adaptive(minimum: 64, maximum: 100))
                ]
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(movies) { movie in
                            VStack {
                                if let imageURL = movie.imageURL {
                                    AsyncImage(url: imageURL)
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .padding()
                                }
                                if let movieName = movie.name {
                                    Text(movieName)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
