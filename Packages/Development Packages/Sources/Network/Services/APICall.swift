//
//  APICall.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

public protocol APICall {
    //MARK: - Properties
    
    var path: String { get }
    
    var method: String { get }
    
    var headers: [String: String]? { get }
    
    func body() throws -> Data?
}

extension APICall {
    // MARK: - Functions
    
    public func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
}
