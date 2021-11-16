//
//  INetworking.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

public protocol INetworking {
    // MARK: - Properties
    
    var session: URLSession { get }
    
    var baseURL: String { get }
}

extension INetworking {
    // MARK: - Functions
    
    public func call<T: Decodable>(
        endpoint: APICall,
        httpCodes: HTTPCodes = .success,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            let task = createDataTask(
                httpCodes: httpCodes,
                from: request,
                completion: completion
            )
            
            task.resume()
        } catch {
            completion(.failure(.wrongRequest))
        }
    }
 
    private func createDataTask<T: Decodable>(
        httpCodes: HTTPCodes,
        from request: URLRequest,
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let code = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(.unexpectedResponse))
                return
            }
            guard httpCodes.contains(code) else {
                completion(.failure(.httpCode(code)))
                return
            }
            guard let data = data else {
                completion(.failure(.cannotDecode(data)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(
                    T.self,
                    from: data
                )
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                completion(.failure(.cannotDecode(data)))
            }
        }
    }
}
