//
//  NetworkClient.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 30.07.2024.
//

import Foundation
import Alamofire

final class NetworkClient {
    
    var session = Session.default
    
    func send<T: Decodable>(_ request: NetworkRequest, _ type: T.Type = T.self) async throws -> T {
        let urlRequest = try request.urlRequest()
        
        let dataResponse = await session.request(urlRequest)
            .validate(statusCode: 200..<300)
            .serializingData()
            .response
        
        guard let data = dataResponse.data, let response = dataResponse.response else {
            throw NetworkError.unknown
        }
        
        // Handle network response errors
        try handleNetworkResponse(data: data, response: response)
        
        do {
            return try decode(from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
    
    private func decode<T: Decodable>(from data: Data) throws -> T {
        return try Decode().decode(T.self, from: data)
    }
    
    private func handleNetworkResponse(data: Data?, response: URLResponse?) throws {
    
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let errorMessage = try? JSONDecoder().decode(ServerError.self, from: data ?? Data())
            throw NetworkError.serverError(httpResponse.statusCode, errorMessage?.message)
        }

        guard data != nil else {
            throw NetworkError.invalidUrl
        }
    }
}
