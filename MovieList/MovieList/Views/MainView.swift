//
//  ContentView.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @State var showFavoriteMovies: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    mainContainerView
                        .padding(.bottom, 24)
                }
                bottomContainer
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                    .popover(isPresented: $showFavoriteMovies) {
                        SavedMoviesView(movies: viewModel.savedMovies())
                            .presentationDetents([.medium])
                            .presentationCornerRadius(24)
                            .presentationDragIndicator(.visible)
                    }
                    .presentationCompactAdaptation(.sheet)
                if viewModel.isLoading {
                    ActivityIndicatorView()
                }
            }
            .toolbar(content: {
                profileButtonView
            })
            .onAppear {
                viewModel.fetchMovies()
            }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {}
        }
    }
    
    var bottomContainer: some View {
        HStack {
            Button(action: {
                showFavoriteMovies = false
            }, label: {
                Image(systemName: "house.circle.fill")
                    .resizable()
                    .scaledToFit()
            })
            .frame(maxWidth: .infinity)
            
            Button(action: {
                showFavoriteMovies = true
            }, label: {
                Image(systemName: "cart.circle.fill")
                    .resizable()
                    .scaledToFit()
            })
            .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
        }
        .frame(height: 48)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    var profileButtonView: some View {
        Button {
            
        } label: {
            Image(systemName: "person.circle.fill")
                .foregroundStyle(Color.gray.opacity(0.5))
        }
    }
    
    var bannerView: some View {
        ZStack {
            if let bannerList = viewModel.movieList?.bannerList {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(bannerList) { movie in
                            if let imageURL = movie.imageURL {
                                AsyncImage(url: imageURL)
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
            }
        }
    }
    
    var mainContainerView: some View {
        ZStack {
            if let combinedList = viewModel.movieList?.combinedList {
                List {
                    bannerView
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    ForEach(viewModel.types, id: \.self) { type in
                        Section(type) {
                            ForEach(combinedList.filter({$0.type == type})) { movie in
                                let isSelected = Binding(get: {
                                        viewModel.isSavedMovie(movie)
                                    }, set: { isSelected in
                                        if isSelected {
                                            viewModel.insertMovieToStorage(movie)
                                        } else {
                                            viewModel.removeMoviewFromStorage(movie)
                                        }
                                    })
                                
                                MovieListItem(
                                    movie: movie,
                                    isSelected: isSelected
                                )
                            }
                        }
                    }
                }
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            }
        }
    }
}

#Preview {
    MainView()
}
