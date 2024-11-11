//
//  MoviesRepositoryMock.swift
//  MovieList
//
//  Created by Furkan ic on 10.11.2024.
//

struct MoviesRepositoryMock: MoviesRepositoryInterface {
    func fetchMovies() async throws -> FetchMoviesListResponse {
        try await EmbeddedFileClient().parseData(with: EmbeddedFileDataModel.movies)
    }
}
