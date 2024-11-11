//
//  EmbeddedFileClient.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 6.08.2024.
//

import Foundation

struct EmbeddedFileClient {
    func parseData<T: Decodable, E: EmbeddedFileDataModelInterface>(with model: E) throws -> T {
        let data = try EmbeddedFileManager().getDataFrom(file: model.fileName)
        guard let typedModel = model.dataModel as? T.Type else {
            throw NetworkError.decodingFailed(nil)
        }
        return try Decode().decode(typedModel, from: data)
    }
    
    func parseData<T: Decodable, E: EmbeddedFileDataModelInterface>(with model: E) async throws -> T {
        let data = try await EmbeddedFileManager().getDataFrom(file: model.fileName)
        
        return try await Task { () -> T in
            try Decode().decode(T.self, from: data)
        }.value
    }
}
