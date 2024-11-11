//
//  EmbeddedFileDataModel.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 6.08.2024.
//

import Foundation

enum EmbeddedFileDataModel {
    case movies
}

extension EmbeddedFileDataModel: EmbeddedFileDataModelInterface {

    var fileName: String {
        switch self {
        case .movies:
            "movies.json"
        }
    }
    
    var dataModel: Decodable.Type {
        switch self {
        case .movies:
            [Movie].self
        }
    }
}
