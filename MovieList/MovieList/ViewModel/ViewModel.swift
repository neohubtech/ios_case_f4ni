//
//  ViewModel.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//
import SwiftUI
import Combine


final class ViewModel: ObservableObject {
    
    @ObservedObject var appStorageUtil = AppStorageUtil()
    var repository: MoviesRepositoryInterface
    @Published var movieList: FetchMoviesListResponse?
    @Published var savedMovie = Set<String>()
    var types: [String] {
        Array(Set(movieList?.combinedList?.compactMap({$0.type}) ?? [])).sorted()
    }
    var cancellables = Set<AnyCancellable>()
    var errorMessage: String = "" {
        didSet {
            showAlert = !errorMessage.isEmpty
        }
    }
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    init(repository: MoviesRepositoryInterface = MoviesRepository()) {
        self.repository = repository
        
        appStorageUtil.objectWillChange
            .sink { [weak self] _ in
            guard let self else { return }
                self.fetchSavedMovies()
        }.store(in: &cancellables)
        
    }
    
    @MainActor
    func fetchMovies() {
        isLoading = true
        Task { [weak self] in
            guard let self else { return }
            do {
                async let movieList = try await self.repository.fetchMovies()
                if await ((try movieList.bannerList?.isEmpty) != nil) {
                    self.movieList = try await movieList
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            fetchSavedMovies()
            isLoading = false
        }
    }
    
    func fetchSavedMovies() {
        savedMovie = (try? appStorageUtil.retrieveSavedMovie()) ?? []
    }
    
    func savedMovies() -> [Movie] {
        movieList?.combinedList?.filter({ movie in
            savedMovie.contains(movie.name ?? "")
        }) ?? []
    }
    
    func isSavedMovie(_ movie: Movie) -> Bool {
        savedMovie.contains(movie.name ?? "")
    }
    
    func insertMovieToStorage(_ movie: Movie) {
        guard let movieName = movie.name else { return }
        try? appStorageUtil.addMovieToAppStorage(movieName)
    }
    
    func removeMoviewFromStorage(_ movie: Movie) {
        guard let movieName = movie.name else { return }
        try? appStorageUtil.removeMovieFromAppStorage(movieName)
    }
}
