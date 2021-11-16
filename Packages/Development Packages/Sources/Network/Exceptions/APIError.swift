//
//  APIError.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

public enum APIError: Swift.Error {
    // MARK: - Cases
    
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageProcessing([URLRequest])
    case wrongRequest
    case cannotDecode(Data?)
}

extension APIError: LocalizedError {
    // MARK: - Properties
    
    public var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .httpCode(let code):
            return "Unexpected HTTP code: \(code)"
            
        case .unexpectedResponse:
            return "Unexpected response from the server"
            
        case .imageProcessing:
            return "Unable to load image"
            
        case .wrongRequest:
            return "Wrong request"
            
        case .cannotDecode(let data):
            guard let data = data else {
                return  "Cannot decode result becouse data nil"
            }

            return "Cannot decode result \(String(decoding: data, as: UTF8.self))"
        }
    }
}

public typealias HTTPCode = Int
public typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    public static let success = 200 ..< 300
}
