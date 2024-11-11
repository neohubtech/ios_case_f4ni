//
//  AppStorageUtil.swift
//  MovieList
//
//  Created by Furkan ic on 11.11.2024.
//

import SwiftUI
import Combine


class AppStorageUtil: ObservableObject {
    @AppStorage("savedMovies") var savedMovies: Data = .init() {
        didSet {
            objectWillChange.send()
        }
    }
    
    func retrieveSavedMovie() throws -> Set<String> {
        let array = (try? JSONDecoder().decode([String].self, from: savedMovies)) ?? []
        return Set(array)
    }
    
    func addMovieToAppStorage(_ movieName: String) throws {
        var list = try retrieveSavedMovie()
        list.insert(movieName)
        savedMovies = try encode(list)
    }
    
    func removeMovieFromAppStorage(_ movieName: String) throws {
        var list = try retrieveSavedMovie()
        list.remove(movieName)
        savedMovies = try encode(list)
    }
    
    func encode(_ setOfString: Set<String>) throws -> Data {
        try JSONEncoder().encode(setOfString)
    }
}

