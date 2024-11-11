//
//  EmbeddedFileDataModelInterface.swift
//  OpenFlight
//
//  Created by Furkan ic on 4.11.2024.
//


protocol EmbeddedFileDataModelInterface {
    var fileName: String { get }
    var dataModel: Decodable.Type { get }
}