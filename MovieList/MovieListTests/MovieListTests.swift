//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Furkan ic on 10.11.2024.
//

import Testing
@testable import MovieList

struct MovieListTests {

    var viewModel = ViewModel(repository: MoviesRepositoryMock())

    @Test("Fetch Movies")
    func fetchMovies() async throws {

        #expect(viewModel.movieList == nil)
        
        await viewModel.fetchMovies()
        
        try await Task.sleep(for: .seconds(1))
        
//        #expect(viewModel.objectWillChange.isFulfilled)
        #expect(viewModel.movieList?.combinedList != nil)
        
    }

    @Test("Save Movie")
    func saveMovie() async throws {
        
        await viewModel.fetchMovies()
        
        await #expect( viewModel.savedMovie.isEmpty)
        
        try await Task.sleep(for: .seconds(1))
        
        let firstMovie = await viewModel.movieList?.combinedList?.first
        
        try #require(firstMovie != nil)

        guard let firstMovie else { return }
            
        await viewModel.insertMovieToStorage(firstMovie)
        
        await #expect(viewModel.savedMovie.contains(firstMovie.name ?? ""))
    }
}
